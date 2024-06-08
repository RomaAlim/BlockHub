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
        displayUserData()
        fetchProfileImage()
        // Hide the back button
              self.navigationItem.hidesBackButton = true
              
              // Alternatively, use a custom empty back button
              let emptyButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
              self.navigationItem.leftBarButtonItem = emptyButton
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
        let backButton = UIBarButtonItem()
                backButton.title = ""
                self.navigationItem.backBarButtonItem = backButton
    }
    
    @IBAction func achievementsButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let listAchievsVC = storyboard.instantiateViewController(withIdentifier: "ListAchievsVC") as? ListAchievsVC {
                if let navController = self.navigationController {
                    navController.pushViewController(listAchievsVC, animated: true)
                } else {
                    print("Navigation controller is not available")
                }
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
            if let calendarVC = storyboard.instantiateViewController(withIdentifier: "CalendarViewController") as? CalendarViewController {
                if let navController = self.navigationController {
                    navController.pushViewController(calendarVC, animated: true)
                } else {
                    print("Navigation controller is not available")
                }
            }
    }
    
    private func displayUserData() {
            let userDefaults = UserDefaults.standard
            
            if let name = userDefaults.string(forKey: "userName"),
               let email = userDefaults.string(forKey: "userEmail") {
                
                profileFullNameLabel.text = name
                profileEmailLabel.text = email
            } else {
                profileFullNameLabel.text = "Name: N/A"
                profileEmailLabel.text = "Email: N/A"
            }
        }
    
    private func fetchProfileImage() {
          guard let token = TokenStorageService.shared.getToken() else {
              print("No token found")
              return
          }

          let url = URL(string: "https://educationplatform-juhi.onrender.com/api/v1/user/image")!
          var request = URLRequest(url: url)
          request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
          request.httpMethod = "GET"

          URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
              if let error = error {
                  print("Failed to fetch profile image: \(error)")
                  return
              }

              guard let data = data, let imageUrlString = String(data: data, encoding: .utf8), let imageUrl = URL(string: imageUrlString) else {
                  print("Invalid data or URL string")
                  return
              }

              URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                  if let error = error {
                      print("Failed to load image: \(error)")
                      return
                  }

                  guard let data = data, let image = UIImage(data: data) else {
                      print("Failed to decode image data")
                      return
                  }

                  DispatchQueue.main.async {
                      self?.profileImageView.image = image
                  }
              }.resume()
          }.resume()
      }
    
}
