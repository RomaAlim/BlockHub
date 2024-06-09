//
//  ListOfChaptersView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 04.06.2024.
//

import UIKit

class ListOfChaptersView: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameOfCourseUI: UILabel!
    
    var course: Course?
        var modules: [CourseModule] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "ChaptersTableCell", bundle: nil), forCellReuseIdentifier: "ChaptersTableCell")
            updateUI()
            if let course = course {
                populateModules(from: course)
            }
        }

        func updateUI() {
            self.view.backgroundColor = .link
            nameOfCourseUI.backgroundColor = .link
        }

        func populateModules(from course: Course) {
            nameOfCourseUI.text = course.name
            modules = course.modules
            tableView.reloadData()
        }
    }

    extension ListOfChaptersView: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return modules.count
        }
         
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChaptersTableCell", for: indexPath) as? ChaptersTableCell else {
                return UITableViewCell()
            }
             
            let module = modules[indexPath.row]
            cell.chapterTitleUI.text = module.title
            cell.updateUI()
             
            return cell
        }
         
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130 // Adjust the height as needed
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedModule = modules[indexPath.row]
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let completingVC = storyboard.instantiateViewController(withIdentifier: "CompletingViewController") as? CompletingViewController {
                completingVC.module = selectedModule
                navigationController?.pushViewController(completingVC, animated: true)
            }
        }
    }
