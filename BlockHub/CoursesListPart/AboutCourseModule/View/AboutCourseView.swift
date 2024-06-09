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
    @IBOutlet weak var whatWillLearnField: UITextView!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var learningPlanField: UITextView!
    @IBOutlet weak var registrationButtonUI: UIButton!
    @IBOutlet weak var viewColorEditeted: UIView!
    @IBOutlet weak var localizedObjective: UILabel!
    @IBOutlet weak var localizedDesription: UILabel!
    @IBOutlet weak var localizedPlan: UILabel!
    
    var courseID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        updateUI()
        updateLocalizable()
        fetchCourseData()
    }
    
    @IBAction func registrationButtonAction(_ sender: Any) {
        enrollInCourse()
        
    }
    
    
    func updateUI() {
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
        
            registrationButtonUI.backgroundColor = .link
            viewColorEditeted.backgroundColor = .link
        }

        func showRegistrationAlert(message: String) {
            let alertController = UIAlertController(title: "Congratulations!", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }

        func updateLocalizable() {
            localizedPlan.text = "course_objectives".localized
            localizedObjective.text = "objectives".localized
            localizedDesription.text = "descriptions".localized
            registrationButtonUI.setTitle("registration_course".localized, for: .normal)
        }

        func fetchCourseData() {
            guard let courseID = courseID else {
                return
            }

            CourseService.shared.getCourse(courseID: courseID) { result in
                switch result {
                case .success(let course):
                    self.updateCourseUI(with: course)
                case .failure(let error):
                    print("Failed to fetch course data: \(error)")
                }
            }
        }

        func updateCourseUI(with course: Course) {
            nameOfCourseUI.text = course.name
            miniDescription1UI.text = course.description
            minidescription2UI.text = course.level
            whatWillLearnField.text = course.skills.map { $0.skillDescription }.joined(separator: ", ")
            descriptionField.text = course.description
            learningPlanField.text = course.modules.map { $0.title }.joined(separator: "\n")
        }

    func enrollInCourse() {
           guard let courseID = courseID else {
               print("Course ID is not available")
               return
           }

           CourseService.shared.enrollInCourse(courseID: courseID) { result in
               switch result {
               case .success(let message):
                   print("Successfully enrolled in course: \(message)")
                   self.showRegistrationAlert(message: "You have successfully registered for the course. It has been added to your favorites.")
                   
                   // Сохранение регистрации курса
                   CourseManager.shared.saveRegistration(courseId: "\(courseID)")
                   
               case .failure(let error):
                   print("Failed to enroll in course: \(error)")
                   self.showRegistrationAlert(message: "Failed to register for the course. Please try again.")
               }
           }
       }
   }
