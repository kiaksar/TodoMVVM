//
//  NetworkManager.swift
//  TodoMVVM
//
//  Created by kiamt01 on 2/15/26.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let session: Session
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        
        let interceptor = CustomInterceptor(apiKey: "pR4vN8xQ2mT7kY9wZ3jB6cF0hL5eA1uD")
        
        session = Session(configuration: configuration, interceptor: interceptor)
    }
}

struct CustomInterceptor: RequestInterceptor {
    let apiKey: String
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.headers.add(.init(name: "X-API-Key", value: apiKey))
        request.headers.add(.init(name: "Content-Type", value: "application/json"))
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error))
        }
        completion(.retry)
    }
}

