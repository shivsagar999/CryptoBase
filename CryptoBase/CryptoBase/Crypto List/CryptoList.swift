//
//  CryptoList.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 06/05/22.
//

import SwiftUI

struct CryptoList: View {
    @ObservedObject var cryptoListVM = CryptoListViewModel()
    var body: some View {
        NavigationView {
            List(cryptoListVM.results) { crypto in
                NavigationLink {
                    DetailedCryptoInfo( id: crypto.id, vs_currecy: "USD" , name: crypto.name, value: crypto.current_price )
                } label: {
                    CryptoRow(currency: "USD", crypto: Crypto(id: crypto.id, symbol: crypto.symbol, name: crypto.name, image: crypto.image, current_price:  crypto.current_price, price_change_percentage_24h: crypto.price_change_percentage_24h))
                    
                }
                
            }.navigationTitle("CryptoBase")
                .task {
                    do {
                        try await cryptoListVM.getAllCrypto(currency: "USD")
                      
                    } catch {
                        print(error)
                    }
                    
                }
        }.onAppear {
            
            
        }
    }
}

struct CryptoList_Previews: PreviewProvider {
    static var previews: some View {
        CryptoList()
    }
}

