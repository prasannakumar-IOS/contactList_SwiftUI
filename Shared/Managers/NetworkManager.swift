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
    
    func postRequest<T: Decodable>(URL: URLConvertible, parameters: Parameters?, encoding: ParameterEncoding, header: HTTPHeaders?) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        return serverRequest(url: URL, httpMethod: .post, parameters: parameters, encoding: encoding, headers: header)
    }
    
    private func serverRequest<T: Decodable>(url: URLConvertible, httpMethod: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?) -> AnyPublisher<DataResponse<T, NetworkError>, Never> {
        AF.request(url, method: httpMethod, parameters: parameters, encoding: encoding, headers: headers).response { response in
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
    
}
