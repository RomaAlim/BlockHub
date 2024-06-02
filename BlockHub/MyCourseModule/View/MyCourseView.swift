//
//  MyCourseView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class MyCourseView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let courses = [
            MyCourse(name: "Blockchain BASICS", numberOfLessons: 64, completedLessons: 62),
            MyCourse(name: "Blockchain ADVANCED", numberOfLessons: 50, completedLessons: 45),
            MyCourse(name: "Smart Contracts", numberOfLessons: 40, completedLessons: 30),
            // Добавьте остальные курсы
        ]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self  // Установите делегат
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
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
            cell.NameOfEducation.text = course.name
            cell.NumberOfLessons.text = "\(course.completedLessons) из \(course.numberOfLessons) уроков"
            cell.ProgresView.progress = course.progress
            
            return cell
        }
    }

    extension MyCourseView: UITableViewDelegate {
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130// Укажите нужную высоту ячейки
        }
    }
