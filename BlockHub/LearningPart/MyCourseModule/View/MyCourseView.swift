//
//  MyCourseView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class MyCourseView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var localizedMyCourses: UILabel!
    
    var courses: [Course] = []

       override func viewDidLoad() {
           super.viewDidLoad()
           
           tableView.dataSource = self
           tableView.delegate = self
           tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
           updateUI()
           fetchUserCourses()
       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
       func updateUI() {
           let backButton = UIBarButtonItem()
           backButton.title = ""
           self.navigationItem.backBarButtonItem = backButton
           localizedMyCourses.text = "my_courses".localized
       }

       func fetchUserCourses() {
           CourseService.shared.getUserCourses { result in
               switch result {
               case .success(let courses):
                   self.courses = courses
                   self.tableView.reloadData()
               case .failure(let error):
                   print("Failed to fetch user courses: \(error)")
               }
           }
       }
   }

   extension MyCourseView: UITableViewDataSource {
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return courses.count
       }
        
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
               return UITableViewCell()
           }
            
           let course = courses[indexPath.row]
           cell.configure(with: course)
           cell.delegate = self
            
           return cell
       }
   }

   extension MyCourseView: UITableViewDelegate {
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 130 // Specify the desired cell height
       }
   }

   extension MyCourseView: TableViewCellDelegateMyCourseModule {
       func didTapCourseInformationButton(cell: TableViewCell) {
           guard let indexPath = tableView.indexPath(for: cell) else { return }
           let selectedCourse = courses[indexPath.row]
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let aboutCourseVC = storyboard.instantiateViewController(withIdentifier: "AboutCourseView") as? AboutCourseView {
               aboutCourseVC.courseID = selectedCourse.id
               navigationController?.pushViewController(aboutCourseVC, animated: true)
           }
       }
       
       func didTapNextButton(cell: TableViewCell) {
           guard let indexPath = tableView.indexPath(for: cell) else { return }
           let selectedCourse = courses[indexPath.row]
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           if let listOfChaptersVC = storyboard.instantiateViewController(withIdentifier: "ListOfChaptersView") as? ListOfChaptersView {
               listOfChaptersVC.course = selectedCourse
               navigationController?.pushViewController(listOfChaptersVC, animated: true)
           }
       }
   }
