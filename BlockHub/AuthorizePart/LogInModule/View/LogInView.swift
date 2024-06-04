//
//  LogInView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 29.04.2024.
//

import UIKit

protocol LogInViewInput{
//    var output: LogInViewOutput {get set}
}

protocol LogInViewOutput{
    func userSelectLogIn(withLogin login:String, password:String)
}

class LogInView: UIViewController, LogInViewInput {

    @IBOutlet weak var signInGoogleButtonUI: UIButton!
    @IBOutlet weak var signInButtonUI: UIButton!
    @IBOutlet weak var emailViewCorner: UIView!
    @IBOutlet weak var passwordViewCorner: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func signInGoogleAction(_ sender: Any) {
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
    }
    
    @IBAction func forgotButtonAction(_ sender: Any) {
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
    }
    
    func updateUI(){
        signInGoogleButtonUI.layer.cornerRadius = 10
        signInButtonUI.layer.cornerRadius = 10
        emailViewCorner.layer.cornerRadius = 10
        passwordViewCorner.layer.cornerRadius = 10
    }
}
