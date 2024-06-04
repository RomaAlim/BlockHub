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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
}
