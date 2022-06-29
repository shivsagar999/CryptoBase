
//  DetailedCryptoInfo.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 11/05/22.


import SwiftUI

struct TimeRangeAndValue: Hashable{
    let range: Int
    let value: Calendar.Component
    let apiName: String
}

struct DetailedCryptoInfo: View {
    
    @ObservedObject var DetailedCryptoInfoVM =  DetailedCryptoInfoViewModel()
    
    var id: String
    var vs_currecy: String
    var name: String
    var changePercentage: Float {
        switch(timeRange) {
        case "1D":
            return DetailedCryptoInfoVM.percentagechange?.price_change_percentage_24h_in_currency ?? 0.0
        case "1W":
            return DetailedCryptoInfoVM.percentagechange?.price_change_percentage_7d_in_currency  ?? 0.0
        case "1M":
            return DetailedCryptoInfoVM.percentagechange?.price_change_percentage_30d_in_currency ?? 0.0
        case "6M":
            return DetailedCryptoInfoVM.percentagechange?.price_change_percentage_200d_in_currency ?? 0.0
        case "1Y":
            return DetailedCryptoInfoVM.percentagechange?.price_change_percentage_1y_in_currency ?? 0.0
        default:
            return 0.0
        }
    }
    var value: Float
    var startDate: String {
        getStartDate(timeRangeAndvalue: timeRangesAndValues[timeRange]!)
    }
    
    var endDate: String = String(Date().timeIntervalSince1970)
    var values: [Double] {
        var values = [Double]()
        for price in DetailedCryptoInfoVM.info.prices {
            values.append(price[1])
        }
        return values
    }
    let timeRanges = ["1D", "1W", "1M", "6M", "1Y"]
    
    let timeRangesAndValues = ["1D": TimeRangeAndValue(range: 1, value: .day, apiName: "24h"), "1W": TimeRangeAndValue(range: 7, value: .day, apiName: "7d"), "1M": TimeRangeAndValue(range: 1, value: .month, apiName: "30d"), "6M": TimeRangeAndValue(range: 6, value: .month, apiName: "200d"), "1Y": TimeRangeAndValue(range: 1, value: .year, apiName: "1y")]
    @State var timeRange: String = "1D"
    let gridItemLayout = [GridItem(.flexible())]
    
    func getStartDate(timeRangeAndvalue: TimeRangeAndValue) -> String {
        let date = Date()
        let startDate = Calendar.current.date(byAdding: timeRangeAndvalue.value, value: -timeRangeAndvalue.range, to: date)!
        return String(startDate.timeIntervalSince1970)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: DetailedCryptoInfoVM.percentagechange?.image ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                Spacer()
                Image(systemName: "star.fill")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.yellow)
            }
            .padding(.bottom)
            Text(name).font(.title).bold()
            VStack(alignment: .leading) {
                Text (String(value))
                    .font(.title2)
                Text(String(changePercentage) + "%")
                    .foregroundColor(changePercentage >= 0 ? .green : .red)
            }
            
            LineGraph(yValues: values, upperValue: (values.max() ?? 0) + ((values.max() ?? 0) * 5)/100, lowerValue: (values.min() ?? 0) - ((values.min() ?? 0) * 5)/100)
                .stroke(changePercentage >= 0 ? .green : .red, lineWidth: 1.0)
                .frame(width: UIScreen.main.bounds.width - 30 , height: UIScreen.main.bounds.width - 30  , alignment: .center)
                .border(.black)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: gridItemLayout) {
                    ForEach(0..<timeRanges.count) {
                        let title = timeRanges[$0]
                        Text(timeRanges[$0])
                            .frame(width: (UIScreen.main.bounds.width - 60)/5, height: 20.0)
                            .background(timeRanges[$0] == timeRange ? Color.cyan : Color.clear)
                            .cornerRadius(10)
                            .onTapGesture {
                                
                                Task {
                                    try await DetailedCryptoInfoVM.getInfo(id: id, vs_currecy: vs_currecy, startDate: startDate, endDate: endDate)
                                    DispatchQueue.main.async {
                                        self.timeRange = title
                                    }
                                    
                                }
                            }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 40)
            Spacer()
        }
        .padding(.leading, 30)
        .task {
            do {
                try await DetailedCryptoInfoVM.getInfo(id: id, vs_currecy: vs_currecy, startDate: startDate, endDate: endDate)
                try await DetailedCryptoInfoVM.getPriceChangePercentage(id: self.id, vs_currecy: self.vs_currecy, priceChange: "1h,24h,7d,4d,30d,200d,1y")
                
            } catch {
                print(error)
            }
        }
        
    }
}

// MARK: - jhewbhb

struct DetailedCryptoInfo_Previews: PreviewProvider {
    static var previews: some View {
        DetailedCryptoInfo( id: "bitcoin", vs_currecy: "USD", name: "Bitcoin", value: 12344)
    }
}


