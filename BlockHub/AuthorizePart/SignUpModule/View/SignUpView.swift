//
//  SignUpView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class SignUpView: UIViewController {

    
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
    }
    

    @IBAction func googleButtonAction(_ sender: Any) {
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
    }
    
    @IBAction func signInButton(_ sender: Any) {
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
}
