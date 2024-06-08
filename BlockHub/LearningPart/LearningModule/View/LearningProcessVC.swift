//
//  LearningProcessVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 06.06.2024.
//

import UIKit
import PDFKit
import Alamofire

class LearningProcessVC: UIViewController {

    var fileKey: String? // This holds the file key for the PDF

        override func viewDidLoad() {
            super.viewDidLoad()
            fetchPDFUrlAndLoad()
        }
        
        private func fetchPDFUrlAndLoad() {
            guard let fileKey = fileKey else { return }
            
            let urlString = "https://educationplatform-juhi.onrender.com/api/v1/pdfs/get-pdf-url?objectName=\(fileKey)"
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJSYW1hIiwiaWF0IjoxNzE3ODcxMjgwLCJleHAiOjE3MTc5NTc2ODB9.ekgu6Z6FZ6fMqkeGY48EIpyReZ0FidZw9QqaBLa0faJy-oT0oGssSaQqHsSxjd6gFEObE0Y7FO18jIq9f8HMjQ", forHTTPHeaderField: "Authorization")
            
            AF.request(request).responseString { response in
                switch response.result {
                case .success(let pdfUrlString):
                    self.loadPDF(from: pdfUrlString)
                case .failure(let error):
                    print("Failed to fetch PDF URL: \(error)")
                }
            }
        }
        
        private func loadPDF(from urlString: String) {
            guard let pdfURL = URL(string: urlString) else { return }
            
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
    }
