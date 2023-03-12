//
//  MyCoreDataApp.swift
//  MyCoreData
//
//  Created by AndreMacBook on 2023-03-11.
//

import SwiftUI

@main
struct MyCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
