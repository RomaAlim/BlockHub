//
//  SignUpView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class SignUpView: UIViewController, UITextFieldDelegate  {

    
    @IBOutlet weak var passwordViewCorner: UIView!
    @IBOutlet weak var emailViewCorner: UIView!
    @IBOutlet weak var nameViewCorner: UIView!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signUoButton: UIButton!
    @IBOutlet weak var welcometoLabel: UITextView!
    @IBOutlet weak var signinwithGoogleLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var emailLAbel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var alreadyhaveaccountLabel: UILabel!
    @IBOutlet weak var signInUI: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLocalizable()
        updateUI()
        emailField.delegate = self
        passwordField.delegate = self
        fullNameField.delegate = self
        }
    

    @IBAction func googleButtonAction(_ sender: Any) {
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        guard let username = fullNameField.text, let password = passwordField.text, let email = emailField.text else { return }

                AuthService.shared.signUp(username: username, email: email, password: password) { success in
                    DispatchQueue.main.async {
                        if success {
                            print("Sign up and sign in successful for user: \(username)")
                            // Удаление предыдущих данных пользователя
                            UserDefaults.standard.removeObject(forKey: "savedUsername")
                            UserDefaults.standard.removeObject(forKey: "savedEmail")
                            UserDefaults.standard.removeObject(forKey: "savedPassword")

                            // Сохранение новых данных пользователя
                            UserDefaults.standard.set(username, forKey: "savedUsername")
                            UserDefaults.standard.set(email, forKey: "savedEmail")
                            UserDefaults.standard.set(password, forKey: "savedPassword")
                            
                            // Добавляем принты для проверки сохраненных данных
                            print("Saved Username: \(username)")
                            print("Saved Email: \(email)")
                            print("Saved Password: \(password)")
                        } else {
                            print("Sign up or sign in failed for user: \(username)")
                            let alert = UIAlertController(title: "Error", message: "Sign up or sign in failed", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
    }

    
    @IBAction func signInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let loginViewController = storyboard.instantiateViewController(withIdentifier: "LogInView") as? LogInView {
            // Переходим на LoginViewController
            self.navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
    
    func updateUI(){
        passwordViewCorner.layer.cornerRadius = 10
        emailViewCorner.layer.cornerRadius = 10
        nameViewCorner.layer.cornerRadius = 10
        googleButton.layer.cornerRadius = 10
        signUoButton.layer.cornerRadius = 10
    }
    func updateLocalizable(){
        welcometoLabel.text = "welcome".localized
        signUoButton.titleLabel?.text = "signup".localized
        signinwithGoogleLabel.text = "signin_email".localized
        fullnameLabel.text = "fullname".localized
        emailLAbel.text = "email".localized
        passwordLabel.text = "password".localized
        googleButton.titleLabel?.text = "signin_google".localized
        alreadyhaveaccountLabel.text = "already_have_account".localized
        signInUI.titleLabel?.text = "signin".localized
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
