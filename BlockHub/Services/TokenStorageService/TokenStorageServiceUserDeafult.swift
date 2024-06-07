//
//  TokenStorageServiceUserDeafult.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import Foundation

class TokenStorageService {
    static let shared = TokenStorageService()
    
    private let tokenKey = "authToken"
    
    private init() {}
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}

