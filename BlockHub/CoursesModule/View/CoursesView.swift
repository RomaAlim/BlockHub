//
//  CoursesView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class CoursesView: UIViewController {

    

    @IBOutlet weak var tableView: UITableView!
    let DateListOfCourse = [
        ListOfCourse(name: "Blockchain BASICS", numberOfLessons: 64, completedLessons: 62, description1: "Introduction to Blockchain", description2: "Basics of Distributed Ledger", cost: "Free", imageName: "ListOfCoursesImage"),
        ListOfCourse(name: "Blockchain ADVANCED", numberOfLessons: 50, completedLessons: 45, description1: "Advanced Blockchain Concepts", description2: "In-depth Ledger Analysis", cost: "Free", imageName: "ListOfCoursesImage"),
        ListOfCourse(name: "Smart Contracts", numberOfLessons: 40, completedLessons: 30, description1: "Introduction to Smart Contracts", description2: "Solidity and Ethereum", cost: "Free", imageName: "ListOfCoursesImage"),
        ListOfCourse(name: "Decentralized Applications", numberOfLessons: 45, completedLessons: 35, description1: "Building DApps", description2: "Using Web3.js", cost: "Free", imageName: "ListOfCoursesImage"),
        ListOfCourse(name: "Crypto Trading", numberOfLessons: 30, completedLessons: 28, description1: "Introduction to Crypto Trading", description2: "Technical Analysis", cost: "Free", imageName: "ListOfCoursesImage"),
        ListOfCourse(name: "Blockchain Security", numberOfLessons: 55, completedLessons: 50, description1: "Blockchain Security Fundamentals", description2: "Advanced Security Techniques", cost: "Free", imageName: "ListOfCoursesImage")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CoursesTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesTableViewCell")
        tableView.separatorStyle = .none // Убираем стандартные разделители
    }
}

extension CoursesView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DateListOfCourse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesTableViewCell", for: indexPath) as? CoursesTableViewCell else {
            return UITableViewCell()
        }
        
        let course = DateListOfCourse[indexPath.row]
        cell.nameListCourses.text = course.name
        cell.descriptionListCourses1.text = course.description1
        cell.descriptionListCourses2.text = course.description2
        cell.costListCourses.text = course.cost
        cell.imageViewListCourses.image = UIImage(named: course.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400 // Укажите нужную высоту ячейки
    }
    
    // Устанавливаем пространство между ячейками через contentInset
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            let topInset = scrollView.contentInset.top
            scrollView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 20, right: 0)
        }
    }
}
