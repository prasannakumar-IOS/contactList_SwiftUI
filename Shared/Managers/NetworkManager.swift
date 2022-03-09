//
//  NetworkManager.swift
//  ContactList
//
//  Created by Prasannakumar Manikandan on 02/03/22.
//

import SwiftUI
import Combine
import Alamofire


class NetworkManager: NSObject {
    
    static let shared: NetworkManager = NetworkManager()
    private let kJSONHeader = "application/json"
    private let kRetryLimit = 3
    
    func postRequest<T: Decodable>(URL: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding, header: HTTPHeaders?) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        return serverRequest(url: URL, httpMethod: .post, parameters: parameters, encoding: encoding, headers: header)
    }
    
    func getRequest<T: Decodable>(url: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        return serverRequest(url: url, httpMethod: .get, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    func delRequest<T: Decodable>(url: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        return serverRequest(url: url, httpMethod: .delete, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    private func serverRequest<T: Decodable>(url: URLConvertible, httpMethod: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, interceptor: RequestInterceptor? = nil) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        AF.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers, interceptor: interceptor ?? self).response { response in
            debugPrint(response.response?.statusCode ?? 0)
            debugPrint(response.request?.url ?? "")
            debugPrint(response.response ?? "")
        }
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                    
                }
            }
            
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func request(url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding?, interceptor: RequestInterceptor? = nil, onSuccess: @escaping (_ response: AFDataResponse<Any>?) -> Void, onFailureBlock: @escaping (_ response: AFDataResponse<Any>?, _ cancelStatus: Bool? ) -> (Void)) -> Request {
        return AF.request(url, method: method, parameters: parameters, encoding: encoding!, interceptor: interceptor ?? self).validate().responseJSON { response in
            debugPrint(response)
            switch response.result {
            case .success(_):
                onSuccess(response)
            case .failure(_):
                if response.response?.statusCode == -999 {
                    onFailureBlock(response, true)
                }
                onFailureBlock(response, false)
            }
        }
    }

    func get(url: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding?, onSuccess: @escaping (_ response: AFDataResponse<Any>?) -> Void , onFailureBlock: @escaping (_ response: AFDataResponse<Any>?, _ cancelStatus: Bool?) -> Void) -> Request {
        return request(url: url, method: .get, parameters: parameters, encoding: encoding, onSuccess: onSuccess, onFailureBlock: onFailureBlock)
    }
    
}

extension NetworkManager: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.setValue(kJSONHeader, forHTTPHeaderField: "Content-Type")
        request.setValue(kJSONHeader, forHTTPHeaderField: "Accept")
       
            if let authToken = UserDefaults.standard.object(forKey: "authToken"),
               let refreshToken = UserDefaults.standard.object(forKey: "refreshToken") {
                let bearerToken = "Bearer \(authToken)"
                request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
                request.setValue(refreshToken as? String, forHTTPHeaderField: "Refresh")
            }
            completion(.success(request))
    }
        
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        let statusCode = request.response?.statusCode
        if (statusCode == 401) || statusCode == 440 {
            guard request.retryCount < kRetryLimit else {
                return
            }
            refreshToken { isSuccess in
                isSuccess ? completion(.retry) : completion(.doNotRetry)
            }
        } else {
            completion(.doNotRetry)
        }
    }

    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        _ = UserManager.shared.refreshToken(onSuccess: { response in
            if let data = response?.data, let token = (try? JSONSerialization.jsonObject(with: data, options: [])
                                                       as? [String: Any]) {
                let authToken = token["auth_token"] as? String
                UserDefaults.standard.set(authToken, forKey: "authToken")
                completion(true)
            } else {
                completion(false)
            }
        }, onFailureBlock: { _, _  in
            completion(false)
        })
    }
    
}
