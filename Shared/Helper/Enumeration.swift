//
//  Enumeration.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 02/03/22.
//

enum APIUrlCalls {
    
    case signupUrl
    case activationUrl
    case loginUrl
    case logoutUrl
    case refreshToken
    case changePassword
    case restPassword
    case updateProfile
    case getAllUser
    case searchUser
    case sendFollowRequest
    case getAllFollowRequest
    case acceptFollowRequest
    case declineFollowRequest
    
    private var baseUrl: String {
        return "https://jwt-api-test.herokuapp.com"
    }
    
    var urlString: String {
        switch self {
        case .signupUrl:
            return "\(baseUrl)/users"
        case .activationUrl:
            return "\(baseUrl)/users/confirmation"
        case .loginUrl:
            return "\(baseUrl)/users/sign_in"
        case .logoutUrl:
            return "\(baseUrl)/users/sign_out"
        case .refreshToken:
            return "\(baseUrl)/get_auth_token"
        case .changePassword:
            return "\(baseUrl)/users/change_password"
        case .restPassword:
            return "\(baseUrl)/users/password"
        case .updateProfile:
            return "\(baseUrl)/users"
        case .getAllUser:
            return "\(baseUrl)/home"
        case .searchUser:
            return "\(baseUrl)/requests"
        case .sendFollowRequest:
            return "\(baseUrl)/relationships"
        case .getAllFollowRequest:
            return "\(baseUrl)/requests"
        case .acceptFollowRequest:
            return "\(baseUrl)/relationships"
        case .declineFollowRequest:
            return "\(baseUrl)/relationships"
        }
    }
    
}

