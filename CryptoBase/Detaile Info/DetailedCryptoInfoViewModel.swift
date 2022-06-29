//
//  DetailedCryptoInfoViewModel.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 16/05/22.
//

import Foundation

class DetailedCryptoInfoViewModel: ObservableObject {
    @Published var info = CryptoHistory(prices: [])
    @Published var percentagechange: CryptoChangeInPrices?
    
    func getInfo(id: String, vs_currecy: String, startDate: String, endDate: String) async throws {
        let info = try await CryptoManager.shared.getDetailedCryptoInfo(id: id, vs_currecy: vs_currecy, startDate: startDate, endDate: endDate)
        DispatchQueue.main.async {
            self.info = info
        }
    }
    
    func getPriceChangePercentage(id: String, vs_currecy: String, priceChange: String) async throws {
        let changeInPercentage = try await CryptoManager.shared.getChangeInPricesPercentage(currency: vs_currecy, ids: id, price_change_percentage: priceChange)
        DispatchQueue.main.async {
            self.percentagechange = changeInPercentage
        }
    }
}
