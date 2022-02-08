//
//  SignUpViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 01/02/22.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var personDetails: [userDetails] = []
    
    func SetProfilePic(firstName: String, lastName: String) -> NSData {
        let nameInitialize = UILabel()
        nameInitialize.frame.size = CGSize(width: 50.0, height: 50.0)
        nameInitialize.textColor = UIColor.black25
        nameInitialize.text = firstName + lastName
        nameInitialize.textAlignment = NSTextAlignment.center
        nameInitialize.backgroundColor = UIColor.paleGrey2
        nameInitialize.layer.cornerRadius = 50.0
        UIGraphicsBeginImageContext(nameInitialize.frame.size)
        nameInitialize.layer.render(in: UIGraphicsGetCurrentContext()!)
        let picture = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let pictureData: NSData = picture.pngData()! as NSData
        return pictureData
    }
}

struct userDetails: Identifiable {
    var id = UUID().uuidString
    var email: String
    var name: String
    var company: String
    var phoneNumber: String
    var passWord: String
    var address: String
    var profilePicture: NSData
}
