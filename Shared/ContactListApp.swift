//
//  ContactListApp.swift
//  Shared
//
//  Created by Prasannakumar Manikandan on 31/01/22.
//

import SwiftUI

@main
struct ContactListApp: App {
    
    let persistenceController = PersistenceManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
