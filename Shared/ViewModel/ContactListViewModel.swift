//
//  ContactListVIewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 08/02/22.
//

import SwiftUI

class ContactListViewModel {
    
    func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.paleGrey2
        UINavigationBar.appearance().standardAppearance = appearance;
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance
    }
}

