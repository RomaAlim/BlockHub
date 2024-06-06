//
//  ProfileView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class ProfileView: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileFullNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
      
    }
    
    func updateUI(){
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    @IBAction func achievementsButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let listAchievsVC = storyboard.instantiateViewController(withIdentifier: "ListAchievsVC") as? ListAchievsVC {
                navigationController?.pushViewController(listAchievsVC, animated: true)
            }
    }
    
    @IBAction func languageButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Select Language", message: nil, preferredStyle: .alert)
            
            let kazAction = UIAlertAction(title: "Kaz", style: .default) { _ in
                self.showAlertLanguage(message: "You have selected Kazakh language.")
            }
            
            let rusAction = UIAlertAction(title: "Rus", style: .default) { _ in
                self.showAlertLanguage(message: "You have selected Russian language.")
            }
            
            let engAction = UIAlertAction(title: "ENG", style: .default) { _ in
                self.showAlertLanguage(message: "You have selected English language.")
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(kazAction)
            alert.addAction(rusAction)
            alert.addAction(engAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }

        private func showAlertLanguage(message: String) {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    
    @IBAction func notificationButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: "Setting up notification", message: nil, preferredStyle: .alert)
                
                let onAction = UIAlertAction(title: "On", style: .default) { _ in
                    self.showAlertNotification(message: "You have successfully turned on notifications.")
                }
                
                let offAction = UIAlertAction(title: "Off", style: .default) { _ in
                    self.showAlertNotification(message: "You have successfully turned off notifications.")
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                alert.addAction(onAction)
                alert.addAction(offAction)
                alert.addAction(cancelAction)
                
                present(alert, animated: true, completion: nil)
            }
            
            private func showAlertNotification(message: String) {
                let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    
    @IBAction func calendarButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let listAchievsVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController {
                navigationController?.pushViewController(listAchievsVC, animated: true)
            }
    }
}
