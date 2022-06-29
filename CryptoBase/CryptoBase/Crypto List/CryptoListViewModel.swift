//
//  File.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 16/05/22.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    @Published var results = [Crypto]()

    func getAllCrypto(currency: String) async throws {
        do {
            let result = try await CryptoManager.shared.getAllCrypto(currency: currency)
            DispatchQueue.main.async {
                self.results = result
            }
        } catch {
            print(error)
        }
    }
}
