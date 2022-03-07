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
    @StateObject var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(.darkishPink)
                .environmentObject(appState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
