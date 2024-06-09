//
//  FaceIDService.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 09.06.2024.
//

import LocalAuthentication
import UIKit

class FaceIDService {
    static let shared = FaceIDService()
    
    private init() {}
    
    func authenticateUser(completion: @escaping (Bool, Error?) -> Void) {
        let context = LAContext()
        var error: NSError?
        
        // Проверка доступности биометрической аутентификации
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Запуск аутентификации Face ID
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Для доступа к аккаунту используйте Face ID") { success, authenticationError in
                DispatchQueue.main.async {
                    completion(success, authenticationError)
                }
            }
        } else {
            // Биометрическая аутентификация недоступна
            DispatchQueue.main.async {
                completion(false, error)
            }
        }
    }
}
