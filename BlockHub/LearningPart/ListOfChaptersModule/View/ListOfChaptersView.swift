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
    
    let chapters = [
        Chapter(title: "Введение в Блокчейн", progressText: "Не начат"),
        Chapter(title: "1. Основы Блокчейна. Концепции и Терминология", progressText: "10/10"),
        Chapter(title: "2. Углубленное изучение Блокчейна. Механизмы и Примеры", progressText: "13/13"),
        Chapter(title: "3. Смарт-контракты. Введение и Применение", progressText: "7/7"),
        Chapter(title: "4. Разработка на Solidity. Практические Уроки", progressText: "7/7"),
        Chapter(title: "5. Децентрализованные Приложения (DApps). Создание и Развертывание", progressText: "7/7")
    ]
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         tableView.dataSource = self
         tableView.delegate = self
         tableView.register(UINib(nibName: "ChaptersTableCell", bundle: nil), forCellReuseIdentifier: "ChaptersTableCell")
         updateUI()
     }
    
    func updateUI(){
        if let gradientColor = UIView.createGradientBackground() {
            self.view.backgroundColor = gradientColor
            nameOfCourseUI.backgroundColor = gradientColor
        }


    }
 }

extension ListOfChaptersView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChaptersTableCell", for: indexPath) as? ChaptersTableCell else {
            return UITableViewCell()
        }
         
        let chapter = chapters[indexPath.row]
        cell.chapterTitleUI.text = chapter.title
        cell.progressTextUI.text = chapter.progressText
        cell.updateUI()
         
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130 // Adjust the height as needed
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Instantiate and navigate to the CompletingViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let completingVC = storyboard.instantiateViewController(withIdentifier: "CompletingViewController") as? CompletingViewController {
            // Pass any data to CompletingViewController if needed
            // completingVC.someProperty = chapters[indexPath.row]
            navigationController?.pushViewController(completingVC, animated: true)
        }
    }
}
