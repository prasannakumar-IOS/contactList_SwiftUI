//
//  ContentView.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 09/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var loginViewModel = LogInViewModel()
    private var isLoggedIn: Bool = (UserDefaults.standard.object(forKey: "isLoggedIn") != nil)
    
    var body: some View {
//        if isLoggedIn {
//            ContactListView(isContactList: $loginViewModel.isContactListOk)
//        } else {
            LoginView()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
