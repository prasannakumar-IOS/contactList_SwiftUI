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
    
    func logOutAPI(parameters: Parameters) -> AnyPublisher<DataResponse<Message, NetworkError>, Never> {
        return NetworkManager.shared.delRequest(url: APIUrlCalls.logoutUrl.urlString, parameters: parameters, encoding: JSONEncoding.default, headers: UserManager.httpHeaders)
    }
    
    func getUserDetails(url: URL, paramters: Parameters? = nil) -> AnyPublisher<DataResponse<AllUsersDetails, NetworkError>, Never> {
        return NetworkManager.shared.getRequest(url: url, parameters: paramters, encoding: JSONEncoding.default, headers: UserManager.httpHeaders)
    }
    
    func refreshToken(onSuccess: @escaping (_ responce: (AFDataResponse<Any>?)) -> Void , onFailureBlock: @escaping (_ responce: AFDataResponse<Any>?, _ cancelStatus: Bool?) -> Void) -> Request {
        return NetworkManager.shared.get(url: APIUrlCalls.refreshToken.urlString, parameters: nil, encoding: JSONEncoding.default, onSuccess: onSuccess, onFailureBlock: onFailureBlock)
    }
    
}
