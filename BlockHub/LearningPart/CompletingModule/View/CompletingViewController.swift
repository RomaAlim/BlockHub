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
    
    
        var module: CourseModule?
        var lessonItems: [LessonItem] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "CompletingTableViewCell", bundle: nil), forCellReuseIdentifier: "CompletingTableViewCell")
            updateUI()
            if let module = module {
                populateLessonsAndTests(from: module)
            }
        }
        
        func updateUI(){
            desctiptionField.isEditable = false
            desctiptionField.isSelectable = true
            desctiptionField.isUserInteractionEnabled = true
            
            description2Field.isEditable = false
            description2Field.isSelectable = true
            description2Field.isUserInteractionEnabled = true

            if let gradientColor = UIView.createGradientBackground() {
                sectionNameLabel.textColor = gradientColor
            }
            Desctiption1Label.text = "course_objectives".localized
            description2Label.text = "what_will_you_learn".localized
            LessonContainsLAbel.text = "lesson_contains".localized
        }
        
        func populateLessonsAndTests(from module: CourseModule) {
            sectionNameLabel.text = module.title
            
            // Creating descriptions for lessons and tests
            let lessonsDescription = module.lessons.map { lesson in
                return "\(lesson.title) (\(lesson.contentType))"
            }.joined(separator: "\n")
            
            let testDescription = module.moduleTest?.testName ?? "No test available"
            
            // Setting text fields with the details
            desctiptionField.text = "Lessons:\n\(lessonsDescription)"
            description2Field.text = "Test:\n\(testDescription)"
            
            // Convert lessons from CourseModule to LessonItem format for displaying in tableView
            lessonItems = module.lessons.map { lesson in
                let lessonType = lesson.contentType == "video" ? "Видео" : "Презентация"
                let image = lesson.contentType == "video" ? UIImage(systemName: "play.circle")! : UIImage(systemName: "doc.text")!
                return LessonItem(image: image, name: lesson.title, type: lessonType, fileKey: lesson.fileKey)
            }
            
            // Add tests from CourseModule to lessonItems
            if let moduleTest = module.moduleTest {
                let testImage = UIImage(systemName: "questionmark.bubble.fill")!
                let testItem = LessonItem(image: testImage, name: moduleTest.testName ?? "", type: "Test", fileKey: nil)
                lessonItems.append(testItem)
            }
            
            tableView.reloadData()
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
            let selectedItem = lessonItems[indexPath.row]
            
            if selectedItem.type == "Test", let moduleTest = module?.moduleTest {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let quizVC = storyboard.instantiateViewController(withIdentifier: "QuizVC") as? QuizVC {
                    quizVC.testID = moduleTest.id // Pass the test ID to QuizVC
                    navigationController?.pushViewController(quizVC, animated: true)
                }
            } else if selectedItem.type == "Презентация", let fileKey = selectedItem.fileKey {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let learningProcessVC = storyboard.instantiateViewController(withIdentifier: "LearningProcessVC") as? LearningProcessVC {
                    learningProcessVC.fileKey = fileKey
                    navigationController?.pushViewController(learningProcessVC, animated: true)
                }
            }
        }
    }
