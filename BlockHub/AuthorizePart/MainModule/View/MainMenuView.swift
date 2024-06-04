//
//  MainMenuView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 14.05.2024.
//

import UIKit

class MainMenuView: UIViewController {

    
    @IBOutlet weak var fieldViewCorner: UIView!
    @IBOutlet weak var computerViewCorner: UIView!
    @IBOutlet weak var signInButtonUI: UIButton!
    @IBOutlet weak var sendButtonUI: UIButton!
    @IBOutlet weak var computerImage: UIImageView!
    @IBOutlet weak var computerText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    
    @IBAction func nextButtonAction(_ sender: Any) {
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
    }
    
    @IBAction func sendButtonAction(_ sender: Any) {
    }
    
    func updateUI(){
        fieldViewCorner.layer.cornerRadius = 10
        computerViewCorner.layer.cornerRadius = 10
        signInButtonUI.layer.cornerRadius = 10
        sendButtonUI.layer.cornerRadius = 10
    }
}


