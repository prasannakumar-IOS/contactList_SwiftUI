//
//  ContactListViewModel.swift
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
    
    func makeAttributedString(firstName: String, lastName: String, searchName: String) -> AttributedString {
        var string = AttributedString(firstName + " " + lastName)
        string.font = .custom("Lato-Regular", size: 18)
        string.foregroundColor = .black85
        if let range = string.range(of: searchName) {
            string[range].font = .custom("Lato-Bold", size: 18)
        } else if let range = string.range(of: firstName) {
            string[range].font = .custom("Lato-Bold", size: 18)
        }
        return string
    }
}

