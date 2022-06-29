//
//  Crypto.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 06/05/22.
//

import Foundation

struct Crypto: Decodable, Identifiable, Equatable {
    var id: String
    var symbol: String
    var name: String
    var image: String
    var current_price: Float
    var price_change_percentage_24h: Float
}


struct CryptoHistory: Decodable {
    var prices: [[Double]]
}

