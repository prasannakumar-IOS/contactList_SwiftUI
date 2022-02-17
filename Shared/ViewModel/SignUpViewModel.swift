//
//  SignUpViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI
import CoreData

class SignUpViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var company: String = ""
    @Published var phoneNumber: String = ""
    @Published var passWord: String = ""
    @Published var streetAddressFirst: String = ""
    @Published var streetAddressSecond: String = ""
    @Published var cityAddress: String = ""
    @Published var stateAddress: String = ""
    @Published var postalCode: String = ""
    @Environment(\.managedObjectContext) var userData
    var persistenceManager = PersistenceManager()
    
    func saveContent() -> Bool {
        if isUserSignUpSuccess() {
            if isDuplicateEmail() {
                let address = streetAddressFirst + "|" + streetAddressSecond + "|" + cityAddress + "|" + stateAddress + "|" + postalCode
                persistenceManager.saveData(userDatas: [firstName, lastName, company, passWord, address, email, SetProfilePic(firstName: String(firstName.first ?? "N"), lastName: String(lastName.first ?? "N")), phoneNumber])
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func SetProfilePic(firstName: String, lastName: String) -> NSData {
        let nameInitialize = UILabel()
        nameInitialize.frame.size = CGSize(width: 50.0, height: 50.0)
        nameInitialize.textColor = UIColor.white
        nameInitialize.text = firstName + lastName
        nameInitialize.textAlignment = NSTextAlignment.center
        nameInitialize.backgroundColor = UIColor.black
        nameInitialize.layer.cornerRadius = 50.0
        UIGraphicsBeginImageContext(nameInitialize.frame.size)
        nameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        let picture = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let pictureData: NSData = picture.pngData()! as NSData
        return pictureData
    }
    
    func isValidEmail() -> Bool {
        let emailValidation = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailValidation.evaluate(with: email)
    }
    
    func isValidPassword() -> Bool {
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordValidation.evaluate(with: passWord)
    }
    
    func isValidPostalCode() -> Bool {
        let postalValidation = NSPredicate(format: "SELF MATCHES %@", postalRegex)
        return postalValidation.evaluate(with: postalCode)
    }
    
    func isValidPhone() -> Bool {
        let phoneValidation = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneValidation.evaluate(with: phoneNumber)
    }
    
    func isUserSignUpSuccess() -> Bool {
        if isValidEmail() && isValidPhone() && isValidPassword() && isValidPostalCode() && firstName != "" && lastName != ""  {
            return true
        } else {
            return false
        }
    }
    
    func isDuplicateEmail() -> Bool {
        let userData = PersistenceManager.shared.fetchUserForLogin(userMail: email)
        if userData.count > 0 {
            return false
        } else {
            return true
        }
    }
}

