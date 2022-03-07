//
//  NetworkManager.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 02/03/22.
//

import SwiftUI
import Alamofire
import Combine

class UserManager: NSObject {
    
    static let shared: UserManager = UserManager()
    static var httpHeaders: HTTPHeaders = HTTPHeaders()
    
    func signUpAPI(parameters: Parameters) -> AnyPublisher<DataResponse<Message, NetworkError>, Never> {
        return NetworkManager.shared.postRequest(URL: APIUrlCalls.signupUrl.urlString, parameters: parameters, encoding: JSONEncoding.default, header: UserManager.httpHeaders)
    }
    
    func logInAPI(parameters: Parameters) -> AnyPublisher<DataResponse<UsersLogin, NetworkError>, Never> {
        return NetworkManager.shared.postRequest(URL: APIUrlCalls.loginUrl.urlString, parameters: parameters, encoding: JSONEncoding.default, header: UserManager.httpHeaders)
    }
    
}
