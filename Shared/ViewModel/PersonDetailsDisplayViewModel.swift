//
//  PersonDetailsDisplayViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 16/02/22.
//

import SwiftUI

class PersonDetailsDisplayViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var company: String = ""
    @Published var email: String = ""
    @Published var phoneNumber: String  = ""
    @Published var streetAddressFirst: String = ""
    @Published var streetAddressSecond: String = ""
    @Published var cityAddress: String = ""
    @Published var stateAddress: String = ""
    @Published var postalCode: String = ""
    @Published var profilePicture: Data = Data()
    
    func fetchStarting(userEmail: String) {
        let userData = PersistenceManager.shared.fetchUserForLogin(userMail: userEmail)[0]
        if let profilePic = userData.profilePicture, let firstName = userData.firstName, let lastName = userData.lastName, let company = userData.company, let phoneNumber = userData.phoneNumber, let address = userData.address, let email = userData.email {
            self.firstName = firstName
            self.lastName = lastName
            self.company = company
            self.phoneNumber = phoneNumber
            self.email = email
            self.profilePicture = profilePic
            let userAddress = address.split(separator: "|") as? [String]
            self.streetAddressFirst = userAddress?[0] ?? ""
            self.streetAddressSecond = userAddress?[1] ?? ""
            self.cityAddress = userAddress?[2] ?? ""
            self.stateAddress = userAddress?[3] ?? ""
            self.postalCode = userAddress?[4] ?? ""
        }
    }
    
    func loadData(defaultPic: Data) -> UIImage {
        if let pref = UserDefaults(suiteName: "group.com.mallow.share") {
            if let imageData = pref.object(forKey: "Image") {
                return UIImage(data: imageData as! Data) ?? UIImage(data: defaultPic)!
            }
        }
        return UIImage(data: defaultPic)!
    }
    
}

