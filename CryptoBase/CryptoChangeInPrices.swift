//
//  CryptoChangeInPrices.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 14/06/22.
//

import Foundation

struct CryptoChangeInPrices: Decodable {
    
    var image: String?
    var price_change_percentage_1h_in_currency: Float?
    var price_change_percentage_1y_in_currency: Float?
    var price_change_percentage_200d_in_currency: Float?
    var price_change_percentage_24h_in_currency: Float?
    var price_change_percentage_30d_in_currency: Float?
    var price_change_percentage_7d_in_currency: Float?
    
}
