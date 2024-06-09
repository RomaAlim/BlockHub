//
//  QuizVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit
import Alamofire

class QuizVC: UIViewController {

    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var numberOfQuestion: UILabel!
    @IBOutlet weak var testProgressView: UIProgressView!
    @IBOutlet weak var QuestionLabel1: UIButton!
    @IBOutlet weak var QuestionLabel2: UIButton!
    @IBOutlet weak var QuestionLabel3: UIButton!
    @IBOutlet weak var QuestionLabel4: UIButton!
    @IBOutlet weak var NoneButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var localizedAnswerAnd: UILabel!
    
    
    var testID: Int?
        var moduleTest: ModuleTest?
        var questions: [TestQuestion] = []
        var currentQuestionIndex = 0
        var selectedAnswerIndex: Int?
        var correctAnswers = 0

        override func viewDidLoad() {
            super.viewDidLoad()
            print("QuizVC loaded. Fetching test data for testID: \(String(describing: testID))")
            fetchTestData()
            updateLocalizable()
        }
        
        func fetchTestData() {
            guard let testID = testID else {
                print("Test ID is nil.")
                return
            }

            guard let token = TokenStorageService.shared.getToken() else {
                print("Token is missing.")
                return
            }

            let urlString = "https://educationplatform-juhi.onrender.com/api/v1/module-tests/\(testID)"
            print("Fetching test data from URL: \(urlString)")
            
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
            
            AF.request(urlString, headers: headers).responseDecodable(of: ModuleTest.self) { response in
                switch response.result {
                case .success(let test):
                    self.moduleTest = test
                    self.questions = test.questions
                    if let moduleTest = self.moduleTest {
                        print("Successfully fetched and decoded test data: \(moduleTest)")
                    } else {
                        print("Successfully fetched test data but it's nil.")
                    }
                    self.updateUI()
                case .failure(let error):
                    if let data = response.data, let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                        print("Failed to fetch test data: \(error). Response JSON: \(json)")
                    } else {
                        print("Failed to fetch test data: \(error)")
                    }
                }
            }
        }

        func updateUI() {
            guard !questions.isEmpty else {
                print("No questions available to display.")
                return
            }
            
            nextButton.setTitle("next".localized, for: .normal)
            let currentQuestion = questions[currentQuestionIndex]
            questionLabel.text = currentQuestion.questionText
            QuestionLabel1.setTitle(currentQuestion.options[0].optionText, for: .normal)
            QuestionLabel2.setTitle(currentQuestion.options[1].optionText, for: .normal)
            QuestionLabel3.setTitle(currentQuestion.options[2].optionText, for: .normal)
            QuestionLabel4.setTitle(currentQuestion.options[3].optionText, for: .normal)
            
            // Reset button states
            resetButtonStates()
            
            // Update progress view
            let progress = Float(currentQuestionIndex + 1) / Float(questions.count)
            testProgressView.setProgress(progress, animated: true)
            
            // Update question number label
            numberOfQuestion.text = "\("step".localized) \(currentQuestionIndex + 1) \("of".localized) \(questions.count)"
            
            // Disable Next button initially
            nextButton.isEnabled = false
            nextButton.layer.cornerRadius = 15
            NoneButton.layer.cornerRadius = 15
            QuestionLabel1.layer.cornerRadius = 15
            QuestionLabel2.layer.cornerRadius = 15
            QuestionLabel3.layer.cornerRadius = 15
            QuestionLabel4.layer.cornerRadius = 15
            
            nextButton.backgroundColor = .link
            
            print("Updated UI with question \(currentQuestionIndex + 1) out of \(questions.count)")
        }

        func resetButtonStates() {
            selectedAnswerIndex = nil
            let buttons = [QuestionLabel1, QuestionLabel2, QuestionLabel3, QuestionLabel4]
            for button in buttons {
                button?.backgroundColor = .white
                button?.layer.borderColor = UIColor.gray.cgColor
                button?.layer.borderWidth = 1.0
            }
        }
    
    @IBAction func questionButtonAction1(_ sender: Any) {
        selectAnswer(at: 0)
    }
    
    @IBAction func questionButtonAction2(_ sender: Any) {
        selectAnswer(at: 1)
    }
    
    @IBAction func questionButtonAction3(_ sender: Any) {
        selectAnswer(at: 2)
    }
    
    @IBAction func questionButtonAction4(_ sender: Any) {//
        selectAnswer(at: 3)
    }
    
    @IBAction func noneButtonAction(_ sender: Any) {
        resetButtonStates()
        nextButton.isEnabled = false
    }
    
    @IBAction func NextButtonAction(_ sender: Any) {
        guard let selectedAnswerIndex = selectedAnswerIndex else { return }
               
               // Validate the answer
               let currentQuestion = questions[currentQuestionIndex]
        if currentQuestion.options[selectedAnswerIndex].isCorrect {
                   correctAnswers += 1
               }
               
               currentQuestionIndex += 1
               if currentQuestionIndex < questions.count {
                   updateUI()
               } else {
                   print("Quiz finished. Correct answers: \(correctAnswers) out of \(questions.count)")
                   submitTestResults()
               }
           }
           
           func selectAnswer(at index: Int) {
               resetButtonStates()
               selectedAnswerIndex = index
               let buttons = [QuestionLabel1, QuestionLabel2, QuestionLabel3, QuestionLabel4]
               let selectedButton = buttons[index]
               
               selectedButton?.backgroundColor = .link
               nextButton.isEnabled = true
               
               print("Selected answer at index \(index) for question \(currentQuestionIndex + 1)")
           }
           
           func updateLocalizable() {
               localizedAnswerAnd.text = "answer_get_points".localized
               nextButton.setTitle("next".localized, for: .normal)
               NoneButton.setTitle("none".localized, for: .normal)
           }
           
           func submitTestResults() {
               guard let testID = testID else { return }

               guard let token = TokenStorageService.shared.getToken() else {
                   print("Token is missing.")
                   return
               }

               let urlString = "https://educationplatform-juhi.onrender.com/api/v1/module-tests/\(testID)"
               let parameters: [String: Any] = [
                   "score": correctAnswers,
                   "totalQuestions": questions.count
               ]

               let headers: HTTPHeaders = [
                   "Authorization": "Bearer \(token)",
                   "Content-Type": "application/json"
               ]

               print("Submitting test results with parameters: \(parameters) to URL: \(urlString)")

               AF.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).response { response in
                   switch response.result {
                   case .success:
                       print("Successfully submitted test results.")
                       self.showTestResult()
                   case .failure(let error):
                       print("Failed to submit test results: \(error)")
                   }
               }
           }
           
           func showTestResult() {
               let alert = UIAlertController(title: "Test Completed", message: "You scored \(correctAnswers) out of \(questions.count).", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                   self.navigationController?.popViewController(animated: true)
               }))
               present(alert, animated: true, completion: nil)
               print("Test completed. Showing results.")
           }
       }
