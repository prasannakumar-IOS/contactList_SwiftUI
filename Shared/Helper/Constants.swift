//
//  Constants.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 09/02/22.
//

import SwiftUI

let emailRegex = "^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$"
let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,15}$"
let postalRegex = "^\\d{6}$"
let phoneRegex = "^\\d{10}$"
let addressInputTitles = ["Street", "Street", "City", "State", "Postal code"]
