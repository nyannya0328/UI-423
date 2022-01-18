//
//  UI_423App.swift
//  UI-423
//
//  Created by nyannyan0328 on 2022/01/18.
//

import SwiftUI

@main
struct UI_423App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
