//
//  QuizVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit

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
    
    
    var questions: [Question] = [
         Question(questionText: "What is Blockchain?", options: ["A database", "A cryptocurrency", "A type of technology", "A security measure"], correctAnswer: 2),
         Question(questionText: "What is Bitcoin?", options: ["A database", "A cryptocurrency", "A type of technology", "A security measure"], correctAnswer: 1),
         Question(questionText: "What is Ethereum?", options: ["A programming language", "A cryptocurrency", "A type of technology", "A security measure"], correctAnswer: 1),
         Question(questionText: "What is Solidity?", options: ["A programming language", "A cryptocurrency", "A type of technology", "A security measure"], correctAnswer: 0),
         Question(questionText: "What is a Smart Contract?", options: ["A physical contract", "A digital contract", "A type of cryptocurrency", "A blockchain application"], correctAnswer: 3),
         Question(questionText: "What is a DApp?", options: ["A database application", "A decentralized application", "A digital application", "A data application"], correctAnswer: 1),
         Question(questionText: "What is Proof of Work?", options: ["A consensus algorithm", "A security measure", "A type of cryptocurrency", "A blockchain"], correctAnswer: 0),
         Question(questionText: "What is Proof of Stake?", options: ["A consensus algorithm", "A security measure", "A type of cryptocurrency", "A blockchain"], correctAnswer: 0)
     ]
     
        var currentQuestionIndex = 0
        var selectedAnswerIndex: Int?
    
        override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
    
        }
        
    func updateUI() {
            let currentQuestion = questions[currentQuestionIndex]
            questionLabel.text = currentQuestion.questionText
            QuestionLabel1.setTitle(currentQuestion.options[0], for: .normal)
            QuestionLabel2.setTitle(currentQuestion.options[1], for: .normal)
            QuestionLabel3.setTitle(currentQuestion.options[2], for: .normal)
            QuestionLabel4.setTitle(currentQuestion.options[3], for: .normal)
            
            // Reset button states
            resetButtonStates()
            
            // Update progress view
            let progress = Float(currentQuestionIndex + 1) / Float(questions.count)
            testProgressView.setProgress(progress, animated: true)
            
            // Update question number label
            numberOfQuestion.text = "Step \(currentQuestionIndex + 1) of \(questions.count)"
            
            // Disable Next button initially
            nextButton.isEnabled = false
            
            // Make imageView circular
//            imageView.layer.cornerRadius = imageView.frame.size.width / 2
//            imageView.clipsToBounds = true
            nextButton.layer.cornerRadius = 15
        nextButton.layer.cornerRadius = 15
        NoneButton.layer.cornerRadius = 15
        QuestionLabel1.layer.cornerRadius = 15
        QuestionLabel2.layer.cornerRadius = 15
        QuestionLabel3.layer.cornerRadius = 15
        QuestionLabel4.layer.cornerRadius = 15
        
        if let gradientColor = UIView.createGradientBackground() {
//            someView.backgroundColor = gradientColor
//            someLabel.textColor = gradientColor
            nextButton.backgroundColor = gradientColor
        }
        

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
        guard selectedAnswerIndex != nil else { return }
        // Handle the answer validation here if needed
        
        // Move to the next question
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            updateUI()
        } else {
            // Quiz finished
            // Handle the end of the quiz here
        }
    }
    
    func selectAnswer(at index: Int) {
            resetButtonStates()
            selectedAnswerIndex = index
            let buttons = [QuestionLabel1, QuestionLabel2, QuestionLabel3, QuestionLabel4]
            let selectedButton = buttons[index]
            
        if let gradientColor = UIView.createGradientBackground() {
            selectedButton?.backgroundColor = gradientColor
   
        }
            nextButton.isEnabled = true
        }
}
