//
//  LogInViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 08/02/22.
//

import SwiftUI

class LogInViewModel {

    
    func checkLoginUser(email: String, password: String, personDetails: [userDetails]) -> Int {
        
        var userLoginError = 0
        
        for users in personDetails {
            if users.email == email {
                if users.passWord == password {
                    userLoginError = 0
                } else {
                    userLoginError = 1
                }
            } else {
                userLoginError = 2
            }
        }
        return userLoginError
    }
}
