//
//  TestVCViewController.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import UIKit
import UserNotifications

class TestVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        requestNotificationPermission()
    }
    
    @IBOutlet weak var testlabel: UILabel!
    
    @IBAction func Show(_ sender: Any) {
        let registrations = CourseManager.shared.loadRegistrations()
         print(registrations)
         NotificationCenter.default.post(name: NSNotification.Name("reloadCalendar"), object: nil)
         completeCourse()
    }
    
    @IBAction func deletetest(_ sender: Any) {
        CourseManager.shared.deleteAllRegistrations()
               NotificationCenter.default.post(name: NSNotification.Name("reloadCalendar"), object: nil)
    }
    func completeCourse() {
           var registrations = CourseManager.shared.loadRegistrations()
           for i in 0..<registrations.count {
               if registrations[i].courseId == "course123" {
                   let calendar = Calendar.current
                   registrations[i].completionDate = calendar.date(byAdding: .day, value: 10, to: registrations[i].deadlineDate)
                   break
               }
           }
           CourseManager.shared.saveRegistrations(registrations)
           NotificationCenter.default.post(name: NSNotification.Name("reloadCalendar"), object: nil)
       }
    
    
    @IBAction func TestNewsPush(_ sender: Any) {
        let message = getRandomMessage(from: NotificationTemplates.newsPush)
                scheduleNotification(title: "🔥 Горячие новости!", body: message, identifier: "newsPush")
            }
    
    @IBAction func TestNewCourse(_ sender: Any) {
        let message = getRandomMessage(from: NotificationTemplates.newCourse)
                scheduleNotification(title: "🎓 Новый курс доступен!", body: message, identifier: "newCourse")
            }
    
    @IBAction func TestMyCourse(_ sender: Any) {
        let message = getRandomMessage(from: NotificationTemplates.myCourse)
                scheduleNotification(title: "📈 Вы продвинулись в курсе!", body: message, identifier: "myCourse")
            }

    
    @IBAction func TestUpdate(_ sender: Any) {
        let message = getRandomMessage(from: NotificationTemplates.update)
                scheduleNotification(title: "🚀 Новое обновление приложения!", body: message, identifier: "update")
            }
    
    
    func requestNotificationPermission() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                if granted {
                    print("Permission granted")
                } else if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }

        func scheduleNotification(title: String, body: String, identifier: String) {
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default

            // Триггер через 1 секунду для немедленного уведомления
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
