//
//  CryptoBaseApp.swift
//  CryptoBase
//
//  Created by MEP LAB 01 on 06/05/22.
//

import SwiftUI

@main
struct CryptoBaseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
