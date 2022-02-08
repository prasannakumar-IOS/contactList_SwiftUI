//
//  ContactListApp.swift
//  Shared
//
//  Created by Prasannakumar Manikandan on 31/01/22.
//

import SwiftUI

@main
struct ContactListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(SignUpViewModel())
        }
    }
}
