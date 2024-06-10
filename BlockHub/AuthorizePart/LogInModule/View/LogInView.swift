//
//  LogInView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 29.04.2024.
//

import UIKit
import LocalAuthentication
protocol LogInViewInput{
//    var output: LogInViewOutput {get set}
}

protocol LogInViewOutput{
    func userSelectLogIn(withLogin login:String, password:String)
}

class LogInView: UIViewController, LogInViewInput, UITextFieldDelegate  {

    @IBOutlet weak var signInGoogleButtonUI: UIButton!
    @IBOutlet weak var signInButtonUI: UIButton!
    @IBOutlet weak var emailViewCorner: UIView!
    @IBOutlet weak var passwordViewCorner: UIView!
    @IBOutlet weak var welcometoLabel: UITextView!
    @IBOutlet weak var signinyouremailLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var signUoButtonUI: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateLocalizable()
        
        emailField.delegate = self
        passwordField.delegate = self
    }

    @IBAction func signInGoogleAction(_ sender: Any) {
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        guard let username = emailField.text, let password = passwordField.text else { return }
                
        AuthService.shared.signIn(username: username, password: password) { success in
            DispatchQueue.main.async {
                if success {
                    print("Sign in successful for user: \(username)")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabbar") as? UITabBarController {
                        mainTabBarController.selectedIndex = 0
                        if let navigationController = self.navigationController {
                            navigationController.pushViewController(mainTabBarController, animated: true)
                        }
                    }
                } else {
                    print("Sign in failed for user: \(username)")
                    let alert = UIAlertController(title: "Error", message: "Sign in failed", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }


    }

    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         if let signUpViewController = storyboard.instantiateViewController(withIdentifier: "SignUpView") as? SignUpView {
             // Переходим на SignUpViewController
             self.navigationController?.pushViewController(signUpViewController, animated: true)
         }
    }
    
    @IBAction func faceIdActionButton(_ sender: Any) {
        FaceIDService.shared.authenticateUser { success, error in
                    if success {
                        print("Face ID authentication successful")
                        // Получение данных пользователя из UserDefaults
                        if let savedUsername = UserDefaults.standard.string(forKey: "savedUsername"),
                           let savedEmail = UserDefaults.standard.string(forKey: "savedEmail"),
                           let savedPassword = UserDefaults.standard.string(forKey: "savedPassword") {
                            print("Retrieved Username: \(savedUsername)")
                            print("Retrieved Email: \(savedEmail)")
                            print("Retrieved Password: \(savedPassword)")
                            self.signInWithFaceID(username: savedUsername, password: savedPassword)
                        }
                    } else {
                        print("Face ID authentication failed")
                        let alert = UIAlertController(title: "Error", message: "Face ID authentication failed", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            func signInWithFaceID(username: String, password: String) {
                AuthService.shared.signIn(username: username, password: password) { success in
                    DispatchQueue.main.async {
                        if success {
                            print("Sign in successful for user: \(username)")
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            if let mainTabBarController = storyboard.instantiateViewController(withIdentifier: "MainTabbar") as? UITabBarController {
                                mainTabBarController.selectedIndex = 0
                                if let navigationController = self.navigationController {
                                    navigationController.pushViewController(mainTabBarController, animated: true)
                                }
                            }
                            
                        } else {
                            print("Sign in failed for user: \(username)")
                            let alert = UIAlertController(title: "Error", message: "Sign in failed", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }
           
           func updateUI() {
               signInGoogleButtonUI.layer.cornerRadius = 10
               signInButtonUI.layer.cornerRadius = 10
               emailViewCorner.layer.cornerRadius = 10
               passwordViewCorner.layer.cornerRadius = 10
           }
           
           func updateLocalizable() {
               signInButtonUI.titleLabel?.text = "signin".localized
               signInGoogleButtonUI.titleLabel?.text = "signin_google".localized
               welcometoLabel.text = "welcome".localized
               signinyouremailLabel.text = "signin_email".localized
               emailLabel.text = "UserName".localized
               passwordLabel.text = "password".localized
               signUoButtonUI.titleLabel?.text = "signup".localized
           }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

       }
