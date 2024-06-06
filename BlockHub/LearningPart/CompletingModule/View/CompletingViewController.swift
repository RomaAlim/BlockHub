//
//  CompletingViewController.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit

class CompletingViewController: UIViewController {

    @IBOutlet weak var sectionNameLabel: UILabel!
    @IBOutlet weak var Desctiption1Label: UILabel!
    @IBOutlet weak var description2Label: UILabel!
    @IBOutlet weak var desctiptionField: UITextView!
    @IBOutlet weak var description2Field: UITextView!
    @IBOutlet weak var LessonContainsLAbel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var lessonItems: [LessonItem] = [
            LessonItem(image: UIImage(systemName: "play.circle")!, name: "Видеоурок \"Основы Backend-разработки и инструменты разработчика\"", type: "Видео"),
            LessonItem(image: UIImage(systemName: "doc.text")!, name: "Учебный материал \"Основы Backend-разработки\"", type: "Презентация"),
            LessonItem(image: UIImage(systemName: "questionmark.bubble.fill")!, name: "Прохождение теста по \"Установка Java Development Kit (JDK)\"", type: "Test"),
        ]
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "CompletingTableViewCell", bundle: nil), forCellReuseIdentifier: "CompletingTableViewCell")
        }
    
    func updateUI(){
        desctiptionField.isEditable = false
        desctiptionField.isSelectable = true
        desctiptionField.isUserInteractionEnabled = true
        
        description2Field.isEditable = false
        description2Field.isSelectable = true
        description2Field.isUserInteractionEnabled = true
    }
    }

    extension CompletingViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return lessonItems.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CompletingTableViewCell", for: indexPath) as? CompletingTableViewCell else {
                return UITableViewCell()
            }
            
            let item = lessonItems[indexPath.row]
            cell.configure(with: item)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 104 // Set the height for each cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Instantiate and navigate to the CompletingViewController
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let completingVC = storyboard.instantiateViewController(withIdentifier: "QuizVC") as? QuizVC {
                // Pass any data to CompletingViewController if needed
                // completingVC.someProperty = chapters[indexPath.row]
                navigationController?.pushViewController(completingVC, animated: true)
            }
        }
    }
