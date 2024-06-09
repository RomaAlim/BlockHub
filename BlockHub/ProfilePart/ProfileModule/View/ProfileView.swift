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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let emptyBackButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = emptyBackButton
        
        navigationItem.hidesBackButton = true
    }

       func updateUI(){
           profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
           profileImageView.clipsToBounds = true
           localizedCallendar.setTitle("calendar".localized, for: .normal)
           localizedAchivements.setTitle("achievements".localized, for: .normal)
           
           blueViewEdite.backgroundColor = .link
           notifationButtonUI.backgroundColor = .link
           lauguagesButtonUI.backgroundColor = .link
           
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
                    self.enableNotifications()
                    self.showAlertNotification(message: NSLocalizedString("You have successfully turned on notifications.", comment: ""))
                }

                let offAction = UIAlertAction(title: NSLocalizedString("Off", comment: ""), style: .default) { _ in
                    self.disableNotifications()
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
            
            private func enableNotifications() {
                UserDefaults.standard.set(true, forKey: "notificationsEnabled")
                UserDefaults.standard.synchronize()
                
                // Schedule notifications if needed
                scheduleDynamicNotifications()
            }
            
            private func disableNotifications() {
                UserDefaults.standard.set(false, forKey: "notificationsEnabled")
                UserDefaults.standard.synchronize()
                
                // Remove all scheduled notifications
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            }
            
            private func scheduleDynamicNotifications() {
                // Schedule dynamic notifications
                let registrations = CourseManager.shared.loadRegistrations()
                for registration in registrations {
                    // Example notification 3 days after registration
                    let reminderMessage = getRandomMessage(from: NotificationTemplates.newsPush)
                    scheduleNotification(title: "Reminder", body: reminderMessage, date: Calendar.current.date(byAdding: .day, value: 3, to: registration.registrationDate)!, identifier: "reminder_\(registration.courseId)_3days")
                    
                    // Example notification one day before the deadline
                    let deadlineMessage = getRandomMessage(from: NotificationTemplates.myCourse)
                    scheduleNotification(title: "Deadline", body: deadlineMessage, date: Calendar.current.date(byAdding: .day, value: -1, to: registration.deadlineDate)!, identifier: "reminder_\(registration.courseId)_1day_before_deadline")
                }
            }
            
            private func scheduleNotification(title: String, body: String, date: Date, identifier: String) {
                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body
                content.sound = .default

                let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                }
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
