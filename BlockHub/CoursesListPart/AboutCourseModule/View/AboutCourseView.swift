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
    @IBOutlet weak var viewColorEditeted: UIView!
    @IBOutlet weak var localizedObjective: UILabel!
    @IBOutlet weak var localizedDesription: UILabel!
    @IBOutlet weak var localizedPlan: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        updateUI()
        updateLocalizable()
    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        showRegistrationAlert()
        
    }
    
    
    func updateUI(){
        miniDescription1UI.layer.cornerRadius = 50
        minidescription2UI.layer.cornerRadius = 50
        registrationButtonUI.layer.cornerRadius = 20
        
        whatWillLearnField.isEditable = false
        whatWillLearnField.isSelectable = true
        whatWillLearnField.isUserInteractionEnabled = true

        descriptionField.isEditable = false
        descriptionField.isSelectable = true
        descriptionField.isUserInteractionEnabled = true

        learningPlanField.isEditable = false
        learningPlanField.isSelectable = true
        learningPlanField.isUserInteractionEnabled = true
        
        if let gradientColor = UIView.createGradientBackground() {
            //costListCourses.textColor = gradientColor
           // registrationButton.setTitleColor(gradientColor, for: .normal)
            registrationButtonUI.backgroundColor = gradientColor
            viewColorEditeted.backgroundColor = gradientColor
        }

    }
    func showRegistrationAlert() {
            let alertController = UIAlertController(title: "Congratulations!", message: "You have successfully registered for the course. It has been added to your favorites.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            CourseManager.shared.saveRegistration(courseId: "course123")
        }
    func updateLocalizable(){
        localizedPlan.text = "course_objectives".localized
        localizedObjective.text = "objectives".localized
        localizedDesription.text = "descriptions".localized
        registrationButtonUI.titleLabel?.text = "registration_course".localized
    }
}
