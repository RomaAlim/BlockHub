//
//  LearningProcessVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit
import PDFKit

class LearningProcessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPDFView()
        //setupBackButton()
    }
    
    private func setupPDFView() {
            guard let pdfURL = Bundle.main.url(forResource: "testPDF", withExtension: "pdf") else { return }
            let pdfDocument = PDFDocument(url: pdfURL)
            
            let pdfView = PDFView(frame: view.bounds)
            pdfView.document = pdfDocument
            pdfView.autoScales = true
            
            view.addSubview(pdfView)
            
            // Adjust pdfView frame to exclude the area of the navigation bar
            pdfView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        
//        private func setupBackButton() {
//            let backButton = UIButton(type: .system)
//            backButton.setTitle("Back", for: .normal)
//            backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//            
//            view.addSubview(backButton)
//            
//            // Position the button at the top-left corner of the view
//            backButton.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
//                backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
//            ])
//        }
//        
//        @objc private func backButtonTapped() {
//            navigationController?.popViewController(animated: true)
//        }
    }
