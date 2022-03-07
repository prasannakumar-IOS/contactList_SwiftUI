//
//  LogInViewModel.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 08/02/22.
//

import SwiftUI
import CoreData
import Combine

class LogInViewModel: ObservableObject {
    
    @Published var userName = "jamesprasanna07+3@gmail.com"
    @Published var passWord = "Prasanna!2"
    @Published var isSignUpOk = false
    @Published var userLogInEmailWrong = false
    @Published var userLogInPasswordWrong = false
    @Published var isContactListOk = false
    @Published var isLoading = false
    var cancelToken: AnyCancellable?
    
    func loginServerCheck() async {
        let parameters: [String: Any] = ["user" : ["login": userName, "password": passWord]]
        guard let urls = URL(string: APIUrlCalls.loginUrl.urlString) else { return }
        var request = URLRequest(url: urls)
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let _ = await loadRequest(request: request)

    }
    
    func loadRequest(request: URLRequest) async {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            print(httpResponse.statusCode)
            do {
                let user = try JSONDecoder().decode(UsersLogin.self, from: data)
                print(user)
            }
        } catch {
            
        }
    }
    
    
    func logINUser() {
        isLoading = true
        let parameters: [String: Any] = ["user" : ["login": userName, "password": passWord]]
        cancelToken = UserManager.shared.logInAPI(parameters: parameters).sink(receiveValue: { response in
            if response.error != nil {
                self.isLoading = false
                print(response.error)
            } else if let data = response.data {
                do {
                    let userValue = try JSONDecoder().decode(UsersLogin.self, from: data)
                    if let userLogin = userValue.user {
                        self.isContactListOk = true
                        self.saveLoginEmail(email: userLogin.email)
                    }
                    if let userToken = userValue.token {
                        self.saveLoginToken(authToken: userToken.authToken ?? "", refreshToken: userToken.refreshToken ?? "")
                    }
                    self.isLoading = false
                } catch {
                    
                }
            }
        })
    }
    
    func saveLoginEmail(email: String) {
        UserDefaults.standard.set(email, forKey: "userLogInEmail")
    }
    
    func saveLoginToken(authToken: String, refreshToken: String) {
        UserDefaults.standard.set(authToken, forKey: "authToken")
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
    }
}
