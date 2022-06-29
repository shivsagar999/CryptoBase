//
//  CryptoManager.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 06/05/22.
//

import Foundation
import SwiftUI

enum CryptoError: Error {
    case fetchingFailed
    case conversionFailed
}

class CryptoManager {
    var results = [Crypto]()
    var detailedCrptoResults = CryptoHistory(prices: [])
    var page = 0
    let session = URLSession(configuration: .default)
    
    static let shared = CryptoManager()
    
    func getAllCrypto(currency: String) async throws -> [Crypto]{
        self.page = self.page + 1
        let vs_currency = URLQueryItem(name: NetworkConstants.vsCurrency, value: currency)
        let order = URLQueryItem(name: NetworkConstants.order, value: "market_cap_desc")
        let per_page = URLQueryItem(name: NetworkConstants.per_page, value: "100")
        let page = URLQueryItem(name: NetworkConstants.page, value: String(page))
        let sparkline = URLQueryItem(name: NetworkConstants.sparkline, value: "false")
        let queryItems = [vs_currency, order, per_page, page, sparkline]
        var urlComps = URLComponents(string: NetworkConstants.kGetAllCryptoInfoURL)!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        //request
        var request = URLRequest(url: url)
        request.timeoutInterval = TimeInterval(exactly: NetworkConstants.kRequestTimeout)!
        request.httpMethod = NetworkConstants.kGet
        //        request.allHTTPHeaderFields = [ NetworkConstants.vsCurrency: "USD", NetworkConstants.order: "market_cap_desc", NetworkConstants.per_page: "100", NetworkConstants.page: "1"  , NetworkConstants.sparkline: "false"
        //        ]
        
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let response = response as? HTTPURLResponse, response.statusCode  == 200 else {
            self.page = self.page - 1
            throw CryptoError.fetchingFailed
        }
        
        let decoder = JSONDecoder()
        
        do {
            let parsedData = try decoder.decode([Crypto].self, from: data)
            
            self.results.append(contentsOf: parsedData)
            
        } catch {
            self.page = self.page - 1
            throw CryptoError.conversionFailed
        }
        
        return results
        //        { data, response, error in
        //                guard error == nil else {
        //                    self.page = self.page - 1
        //                    print(error)
        //                    return
        //                }
        //
        //                guard let response = response as? HTTPURLResponse, response.statusCode  == 200 else {
        //                    self.page = self.page - 1
        //                    return
        //                }
        //
        //                let decoder = JSONDecoder()
        //                if let safeData = data {
        //                    do {
        //                        let parsedData = try decoder.decode([Crypto].self, from: safeData)
        //                        DispatchQueue.main.async {
        //                            self.results.append(contentsOf: parsedData)
        //                        }
        //
        //                    } catch {
        //                        self.page = self.page - 1
        //                        print(error)
        //                    }
        //                } else {
        //                    return
        //                }
        //
        //            }
        //
        //        task.resume()
        
    }
    
    func getDetailedCryptoInfo(id: String, vs_currecy: String, startDate: String, endDate: String) async throws -> CryptoHistory {
        let vs_currency = URLQueryItem(name: "vs_currency", value: vs_currecy)
        let startDate = URLQueryItem(name: "from", value: startDate)
        let endDate = URLQueryItem(name: "to", value: endDate)
        let queryItem = [vs_currency, startDate, endDate]
        var urlComp = URLComponents(string: NetworkConstants.kGetDetailedCryptoInfoURL(id: id))!
        urlComp.queryItems = queryItem
        let url = urlComp.url!
        //request
        var request = URLRequest(url: url)
        request.timeoutInterval = TimeInterval(exactly: NetworkConstants.kRequestTimeout)!
        request.httpMethod = NetworkConstants.kGet
        
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let response = response as? HTTPURLResponse, response.statusCode  == 200 else {
            throw CryptoError.fetchingFailed
        }
        
        let decoder = JSONDecoder()
        do {
            let parsedData = try decoder.decode(CryptoHistory.self, from: data)
            self.detailedCrptoResults = parsedData
        } catch {
            throw CryptoError.conversionFailed
        }
        
        return self.detailedCrptoResults
    }
    
    func getChangeInPricesPercentage(currency: String, ids: String, price_change_percentage: String) async throws -> CryptoChangeInPrices? {
        var changeInPercentage: [CryptoChangeInPrices]?
        let vs_currency = URLQueryItem(name: NetworkConstants.vsCurrency, value: currency)
        let id = URLQueryItem(name: "ids", value: ids)
        let priceChangePercentage = URLQueryItem(name: "price_change_percentage", value: price_change_percentage)
        let queryItems = [vs_currency, id, priceChangePercentage]
        var urlComps = URLComponents(string: NetworkConstants.kGetAllCryptoInfoURL)!
        urlComps.queryItems = queryItems
        let url = urlComps.url!
        //request
        var request = URLRequest(url: url)
        request.timeoutInterval = TimeInterval(exactly: NetworkConstants.kRequestTimeout)!
        request.httpMethod = NetworkConstants.kGet
        
        let (data, response) = try await session.data(for: request, delegate: nil)
        
        guard let response = response as? HTTPURLResponse, response.statusCode  == 200 else {
            throw CryptoError.fetchingFailed
        }
        
        let decoder = JSONDecoder()
        
        do {
            let parsedData = try decoder.decode([CryptoChangeInPrices].self, from: data)
            changeInPercentage = parsedData
        } catch {
            throw CryptoError.conversionFailed
        }
        
        return changeInPercentage?[0]
    }
    
}
