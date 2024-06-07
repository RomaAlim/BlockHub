//
//  ProfileView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit
import UserNotifications

class ProfileView: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileFullNameLabel: UILabel!
    @IBOutlet weak var profileEmailLabel: UILabel!
    @IBOutlet weak var blueViewEdite: UIView!
    @IBOutlet weak var lauguagesButtonUI: UIButton!
    @IBOutlet weak var notifationButtonUI: UIButton!
    @IBOutlet weak var localizedAchivements: UIButton!
    @IBOutlet weak var localizedCallendar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
      
    }
    
    func updateUI(){
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        localizedCallendar.titleLabel?.text =  "calendar".localized
        localizedAchivements.titleLabel?.text = "achievements".localized
        if let gradientColor = UIView.createGradientBackground() {
            blueViewEdite.backgroundColor = gradientColor
            notifationButtonUI.backgroundColor = gradientColor
            lauguagesButtonUI.backgroundColor = gradientColor
        }
    }
    
    @IBAction func achievementsButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let listAchievsVC = storyboard.instantiateViewController(withIdentifier: "ListAchievsVC") as? ListAchievsVC {
                navigationController?.pushViewController(listAchievsVC, animated: true)
            }
    }
    
    @IBAction func languageButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Select Language", comment: ""), message: nil, preferredStyle: .alert)

                let kazAction = UIAlertAction(title: "Kaz", style: .default) { _ in
                    self.setLanguage("kk")
                    self.showAlertLanguage(message: NSLocalizedString("You have selected Kazakh language.", comment: ""))
                }

                let rusAction = UIAlertAction(title: "Rus", style: .default) { _ in
                    self.setLanguage("ru")
                    self.showAlertLanguage(message: NSLocalizedString("You have selected Russian language.", comment: ""))
                }

                let engAction = UIAlertAction(title: "ENG", style: .default) { _ in
                    self.setLanguage("en")
                    self.showAlertLanguage(message: NSLocalizedString("You have selected English language.", comment: ""))
                }

                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)

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

       private func setLanguage(_ languageCode: String) {
           UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
           UserDefaults.standard.synchronize()
           exit(0)
       }
    
    @IBAction func notificationButtonAction(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("Setting up notification", comment: ""), message: nil, preferredStyle: .alert)

                let onAction = UIAlertAction(title: NSLocalizedString("On", comment: ""), style: .default) { _ in
                    self.showAlertNotification(message: NSLocalizedString("You have successfully turned on notifications.", comment: ""))
                }

                let offAction = UIAlertAction(title: NSLocalizedString("Off", comment: ""), style: .default) { _ in
                    self.showAlertNotification(message: NSLocalizedString("You have successfully turned off notifications.", comment: ""))
                }

                let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil)

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
