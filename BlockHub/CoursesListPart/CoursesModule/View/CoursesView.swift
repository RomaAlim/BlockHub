//
//  CoursesView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit
import Alamofire

class CoursesView: UIViewController, CoursesTableDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var courses: [Course] = []
           
       override func viewDidLoad() {
           super.viewDidLoad()
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: "CoursesTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesTableViewCell")
           loadCourses()
       }
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           fetchCourses()
       }
       
       private func loadCourses() {
           if let cachedCourses = CourseService.shared.loadCoursesFromUserDefaults() {
               self.courses = cachedCourses
               self.tableView.reloadData()
               print("Loaded cached courses from UserDefaults: \(cachedCourses.count) courses")
           }
           let backButton = UIBarButtonItem()
                   backButton.title = ""
                   self.navigationItem.backBarButtonItem = backButton
       }
       
       private func fetchCourses() {
           CourseService.shared.getAllCourses { result in
               DispatchQueue.main.async {
                   switch result {
                   case .success(let courses):
                       self.courses = courses
                       self.tableView.reloadData()
                       print("Fetched courses from backend: \(courses.count) courses")
                   case .failure(let error):
                       print("Failed to fetch courses: \(error)")
                       // Показать сообщение об ошибке пользователю
                   }
               }
           }
       }
   }

   extension CoursesView: UITableViewDataSource, UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print("Number of rows in section: \(courses.count)")
           return courses.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as? CoursesTableViewCell else {
               return UITableViewCell()
           }
           
           let course = courses[indexPath.row]
           cell.CourseNameLabel.text = course.name
           cell.descriptionListCourses1.text = course.language
           cell.descriptionListCourses2.text = course.level
           cell.costListCourses.text = "\(course.durationInMonths) months"
           
           // Загрузка изображения из URL
           if let url = URL(string: course.imageKey) {
               URLSession.shared.dataTask(with: url) { data, response, error in
                   if let data = data, error == nil {
                       DispatchQueue.main.async {
                           cell.imageViewListCourses.image = UIImage(data: data)
                       }
                   } else {
                       DispatchQueue.main.async {
                           cell.imageViewListCourses.image = nil
                       }
                   }
               }.resume()
           } else {
               cell.imageViewListCourses.image = nil
           }
           
           cell.delegate = self // Set the delegate
           
           print("Configured cell for course: \(course.name)")
           
           return cell
       }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 400 // Укажите нужную высоту ячейки
       }
   }

   extension CoursesView: CoursesTableViewCellDelegate {
       func didTapRegisterButton(cell: CoursesTableViewCell) {
           guard let indexPath = tableView.indexPath(for: cell) else { return }
           // let selectedCourse = courses[indexPath.row]
           
           // Instantiate and navigate to the AboutCourseView
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let aboutCourseVC = storyboard.instantiateViewController(withIdentifier: "AboutCourseView") as? AboutCourseView {
               // Pass data to AboutCourseView if needed
               // aboutCourseVC.course = selectedCourse
               navigationController?.pushViewController(aboutCourseVC, animated: true)
           }
       }
   }
