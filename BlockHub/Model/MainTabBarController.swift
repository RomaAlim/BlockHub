//
//  MainTabBarController.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 10.06.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем экземпляры view controllers для каждого таба
        let newsVC = createNavController(for: "NewsViewController", title: "News", image: UIImage(systemName: "newspaper")!)
        let coursesVC = createNavController(for: "CoursesViewController", title: "Courses", image: UIImage(systemName: "book")!)
        let myCoursesVC = createNavController(for: "MyCoursesViewController", title: "My Courses", image: UIImage(systemName: "star")!)
        let profileVC = createNavController(for: "ProfileViewController", title: "Profile", image: UIImage(systemName: "person")!)
        
        // Устанавливаем view controllers для табов
        viewControllers = [newsVC, coursesVC, myCoursesVC, profileVC]
    }
    
    fileprivate func createNavController(for identifier: String,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        viewController.navigationItem.title = title
        return navController
    }
}

