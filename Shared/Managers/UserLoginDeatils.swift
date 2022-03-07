//
//  UserDeatils.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 09/02/22.
//

import SwiftUI
import Foundation

struct UsersLogin: Codable {
    
    let user: UserDatas?
    let token: Token?
    
    enum CodingKeys: String, CodingKey {
        case user = "User"
        case token = "Tokens"
    }
    
}

struct UserDatas: Codable, Identifiable {
    
    var id: Int
    let email: String
    let firstName: String?
    let lastName: String?
    let gender: String?
    let dob: Date?
    let phoneNumber: String?
    let avatar: String?
    let address: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, gender, dob, avatar
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case address = "address"
    }
    
}



struct Token: Codable {
    
    let authToken: String?
    var refreshToken: String?
    
    enum  CodingKeys: String, CodingKey {
        case authToken = "Auth_token"
        case refreshToken = "Refresh_token"
    }
    
}
