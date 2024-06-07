//
//  AuthService.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import Foundation
import Alamofire

struct LoginResponse: Codable {
    let token: String?
    let id: Int?
    let username: String?
    let email: String?
    let roles: [String]?
}

class AuthService {
    static let shared = AuthService()
    
    private let signUpURL = "https://educationplatform-juhi.onrender.com/api/v1/auth/signup"
    private let signInURL = "https://educationplatform-juhi.onrender.com/api/v1/auth/signin"
    
    private init() {}
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "email": email,
            "password": password,
            "roles": ["user"]
        ]
        
        print("Attempting to sign up with parameters: \(parameters)")
        
        AF.request(signUpURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: SignUpResponse.self) { response in
            switch response.result {
            case .success(let signUpResponse):
                print("SignUp Response received: \(signUpResponse)")
                if let message = signUpResponse.message {
                    print("SignUp success message: \(message)")
                    // Proceed to sign in after successful sign-up
                    self.signIn(username: username, password: password, completion: completion)
                } else {
                    print("SignUp failed: No message in response")
                    completion(false)
                }
            case .failure(let error):
                print("SignUp failed with error: \(error)")
                completion(false)
            }
        }
    }
    
    func signIn(username: String, password: String, completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        print("Attempting to sign in with parameters: \(parameters)")
        
        AF.request(signInURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseDecodable(of: LoginResponse.self) { response in
            print("SignIn Response received: \(response)")
            
            switch response.result {
            case .success(let loginResponse):
                if let token = loginResponse.token, let username = loginResponse.username, let email = loginResponse.email {
                    TokenStorageService.shared.saveToken(token)
                    UserDefaults.standard.set(username, forKey: "userName")
                    UserDefaults.standard.set(email, forKey: "userEmail")
                    print("Sign in successful, token saved: \(token)")
                    completion(true)
                } else {
                    print("Sign in failed: Token not found in response")
                    completion(false)
                }
            case .failure(let error):
                print("Sign in failed with error: \(error)")
                completion(false)
            }
        }
    }
}




extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.{8,})"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
}

struct SignUpResponse: Codable {
    let message: String?
}

