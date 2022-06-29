//
//  NetworkConstants.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 06/05/22.
//

import Foundation

struct NetworkConstants {
    static private var kCryptoInfo = "/coins/markets"
    static private var kCryptoDetailedInfo = "/coins/bitcoin/market_chart/range"
    static private var kCryptoBasicURL = "https://api.coingecko.com/api/v3"
    
    static let kRequestTimeout = 60.0
    
    //Method-Type
    static let kGet = "GET"
    static let kPost = "POST"
    static let kPut = "PUT"
    
    static let vsCurrency = "vs_currency"
    static let order = "order"
    static let per_page = "per_page"
    static let page = "page"
    static let sparkline = "sparkline"
    
    static var kGetAllCryptoInfoURL: String {
        return kCryptoBasicURL + kCryptoInfo
    }
    
    static func kGetDetailedCryptoInfoURL(id: String) -> String {
        return kCryptoBasicURL + "/coins/" + id + "/market_chart/range"
    }
}
