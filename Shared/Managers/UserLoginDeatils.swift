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

struct AllUsersDetails: Codable {
    var count: Int64?
    var allUsers: [AllUsers]?
    enum CodingKeys: String, CodingKey {
        case count
        case allUsers = "all_users"
    }
}

struct AllUsers: Codable {
    var id: Int64?
    var email: String?
    var createdAt: String?
    var updatedAt: String?
    var firstName: String?
    var lastName: String?
    var gender: String?
    var phoneNumber: String?
    var dob: Date?
    var avatar: String?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, gender, dob, avatar, address
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
    }
}
