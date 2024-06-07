//
//  AuthInterceptorHeader.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import Foundation
import Alamofire

class AuthInterceptor: RequestInterceptor {
    private let tokenStorage = TokenStorageService.shared
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        if let token = tokenStorage.getToken() {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
        }
        
        completion(.success(urlRequest))
    }
}

let session: Session = {
    let interceptor = AuthInterceptor()
    return Session(interceptor: interceptor)
}()
