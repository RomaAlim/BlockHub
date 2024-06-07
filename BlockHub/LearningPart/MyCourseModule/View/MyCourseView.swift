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
    
    let courses = [
        MyCourse(name: "Blockchain BASICS", numberOfLessons: 62, completedLessons: 6),
        MyCourse(name: "Blockchain ADVANCED", numberOfLessons: 45, completedLessons: 12),
        MyCourse(name: "Smart Contracts", numberOfLessons: 40, completedLessons: 40)
    ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            updateUI()
        }
    func updateUI(){
        let backButton = UIBarButtonItem()
                backButton.title = ""
                self.navigationItem.backBarButtonItem = backButton
        localizedMyCourses.text = "my_courses".localized
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
        return 130 // Укажите нужную высоту ячейки
    }
}

extension MyCourseView: TableViewCellDelegateMyCourseModule {
    func didTapCourseInformationButton(cell: TableViewCell) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        let selectedCourse = courses[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let aboutCourseVC = storyboard.instantiateViewController(withIdentifier: "AboutCourseView") as? AboutCourseView {
            // Pass data to AboutCourseView if needed
            // aboutCourseVC.course = selectedCourse
            navigationController?.pushViewController(aboutCourseVC, animated: true)
        }
    }
    
    func didTapNextButton(cell: TableViewCell) {
//        guard let indexPath = tableView.indexPath(for: cell) else { return }
//        let selectedCourse = courses[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let listOfChaptersVC = storyboard.instantiateViewController(withIdentifier: "ListOfChaptersView") as? ListOfChaptersView {
            // Pass data to ListOfChaptersView if needed
            // listOfChaptersVC.course = selectedCourse
            navigationController?.pushViewController(listOfChaptersVC, animated: true)
        }
    }
}
