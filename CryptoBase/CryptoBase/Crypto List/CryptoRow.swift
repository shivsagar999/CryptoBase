//
//  CryptoRow.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 06/05/22.
//

import SwiftUI

struct CryptoRow: View {
    let currency: String
    let crypto: Crypto
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: crypto.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(crypto.name)
                    .font(.system(size: 16))
                HStack {
                    Text("$" + " " + String(format: "%.2f", crypto.current_price))
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                    Text(String(format: "%.2f", crypto.price_change_percentage_24h) + "%")
                        .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)
                        .font(.system(size: 12))
                }
            }
            Spacer()
        }.padding()
    }
}

struct CryptoRow_Previews: PreviewProvider {
    static var previews: some View {
        CryptoRow(currency: "USD", crypto: Crypto(id: "bitcoin", symbol: "BTC", name: "Bitcoin", image: "hggdf", current_price: 12342, price_change_percentage_24h: -23))
    }
}

