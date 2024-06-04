//
//  AboutCourseView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import UIKit

class AboutCourseView: UIViewController {

    
    
    @IBOutlet weak var nameOfCourseUI: UILabel!
    @IBOutlet weak var miniDescription1UI: UILabel!
    @IBOutlet weak var minidescription2UI: UILabel!
    @IBOutlet weak var authorNameUI: UILabel!
    @IBOutlet weak var whatWillLearnField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var learningPlanField: UITextView!
    @IBOutlet weak var registrationButtonUI: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        updateUI()
    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        showRegistrationAlert()
    }
    
    
    func updateUI(){
        miniDescription1UI.layer.cornerRadius = 10
        minidescription2UI.layer.cornerRadius = 10
        registrationButtonUI.layer.cornerRadius = 10
        
        
        
        whatWillLearnField.isEditable = false
        whatWillLearnField.isSelectable = false
        whatWillLearnField.isUserInteractionEnabled = false
        
        descriptionField.isEditable = false
        descriptionField.isSelectable = false
        descriptionField.isUserInteractionEnabled = false
        
        learningPlanField.isEditable = false
        learningPlanField.isSelectable = false
        learningPlanField.isUserInteractionEnabled = false
    }
    func showRegistrationAlert() {
            let alertController = UIAlertController(title: "Congratulations!", message: "You have successfully registered for the course. It has been added to your favorites.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
}
