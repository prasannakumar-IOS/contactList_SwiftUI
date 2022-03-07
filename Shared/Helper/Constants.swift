//
//  Constants.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 09/02/22.
//

import SwiftUI
import Alamofire

let emailRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
let postalRegex = "^\\d{6}$"
let phoneRegex = "^\\d{10}$"
let addressInputTitles = ["Street", "Street", "City", "State", "Postal code"]


struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}

struct Message: Codable {
    var message: String
    enum CodingKeys: String, CodingKey {
        case message
    }
}
