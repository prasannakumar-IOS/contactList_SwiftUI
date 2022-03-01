//
//  LogInViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 08/02/22.
//

import SwiftUI
import CoreData

class LogInViewModel: ObservableObject {
    
    @Published var userName = "James@gmail.com"
    @Published var passWord = "James007@"
    @Published var isSignUpOk = false
    @Published var userLogInEmailWrong = false
    @Published var userLogInPasswordWrong = false
    @Published var isContactListOk = false

    
    func fetchRequest() {
        let userData = PersistenceManager.shared.fetchUserForLogin(userMail: userName)
        if userData.count > 0 {
            for userLogin in userData {
                print("😀\(userLogin.email)")
                if userLogin.password == passWord {
                    isContactListOk = true
                    UserDefaults.standard.set(userName, forKey: "userLogInEmail")
                    let mySharedDefaults = UserDefaults(suiteName: "group.com.mallow.share")
                    mySharedDefaults?.set(true, forKey: "userLogInStatus")
                    break
                } else {
                    userLogInPasswordWrong = true
                    break
                }
            }
        } else {
            userLogInEmailWrong = true
        }
    }

    func getCoreDataDBPath() {
              let path = FileManager
                  .default
                  .urls(for: .applicationSupportDirectory, in: .userDomainMask)
                  .last?
                  .absoluteString
                  .replacingOccurrences(of: "file://", with: "")
                  .removingPercentEncoding

              print("😀Core Data DB Path :: \(path ?? "Not found")")
          }
}
