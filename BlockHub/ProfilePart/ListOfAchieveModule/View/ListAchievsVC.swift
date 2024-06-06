//
//  ListAchievsVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import UIKit

class ListAchievsVC: UIViewController {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var sucessAchiveButtonUI: UIButton!
    @IBOutlet weak var notSucessAchiveButtonUI: UIButton!
    @IBOutlet weak var achiveTextLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var achievements: [Achievement] = []
        var filteredAchievements: [Achievement] = []
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
            
            loadAchievements()
            showAchieved()
            updateUI()
        
        if let gradientColor = UIView.createGradientBackground() {
            self.view.backgroundColor = gradientColor
        }
        
        }
        
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Убедимся, что imageView имеет правильные размеры перед установкой cornerRadius
            personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
        }
        
    func updateUI(){
        // Настройка начального состояния кнопок
        updateButtonStates(isShowingAchieved: true)
        
        // Сделать изображение круглым
        personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
        personImageView.clipsToBounds = true
        
        
    }
        func loadAchievements() {
            // Пример заполнения массива достижений
            if let image1 = UIImage(named: "IconBlock"),
               let image2 = UIImage(named: "IconBlock"),
               let image3 = UIImage(named: "IconBlock"),
               let image4 = UIImage(named: "IconBlock") {
                achievements = [
                    Achievement(id: 1, name: "Blockchain Basics", description: "Completed the blockchain basics course.", image: image1, isAchieved: true),
                    Achievement(id: 2, name: "Smart Contracts", description: "Completed the smart contracts module.", image: image2, isAchieved: false),
                    Achievement(id: 3, name: "Advanced Blockchain", description: "Completed the advanced blockchain course.", image: image3, isAchieved: true),
                    Achievement(id: 4, name: "Blockchain Developer", description: "Completed the blockchain developer course.", image: image4, isAchieved: false)
                ]
            } else {
                print("Error: One or more images could not be found.")
            }
        }
        
        func showAchieved() {
            filteredAchievements = achievements.filter { $0.isAchieved }
            tableView.reloadData()
            updateButtonStates(isShowingAchieved: true)
        }
        
        func showNotAchieved() {
            filteredAchievements = achievements.filter { !$0.isAchieved }
            tableView.reloadData()
            updateButtonStates(isShowingAchieved: false)
        }
        
        func updateButtonStates(isShowingAchieved: Bool) {
            if isShowingAchieved {
                sucessAchiveButtonUI.tintColor = .link
                notSucessAchiveButtonUI.tintColor = .gray
            } else {
                sucessAchiveButtonUI.tintColor = .link
                notSucessAchiveButtonUI.tintColor = .blue
            }
        }
    

    @IBAction func sucessAchiveButtonAction(_ sender: Any) {
        showAchieved()
    }
    
    @IBAction func notSucessAchiveButtonAction(_ sender: Any) {
        showNotAchieved()
    }
    
}

extension ListAchievsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAchievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let achievement = filteredAchievements[indexPath.row]
        cell.achieveNameLabel.text = achievement.name
        cell.achieveDescriptionLabel.text = achievement.description
        cell.achiveImageView.image = achievement.image
        cell.achiveImageView.layer.cornerRadius = cell.achiveImageView.frame.size.width / 2
        cell.achiveImageView.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90 // Установите высоту для каждой ячейки
    }
}
