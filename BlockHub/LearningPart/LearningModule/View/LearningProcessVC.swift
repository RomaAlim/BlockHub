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
           guard let fileKey = fileKey else {
               print("fileKey is nil")
               return
           }
           
           let urlString = "https://educationplatform-juhi.onrender.com/api/v1/pdfs/get-pdf-url?objectName=\(fileKey)"
           guard let url = URL(string: urlString) else {
               print("Invalid URL string: \(urlString)")
               return
           }
           
           guard let token = TokenStorageService.shared.getToken() else {
               print("No auth token found")
               return
           }
           
           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
           
           print("Sending request to URL: \(url)")
           
           AF.request(request).responseString { response in
               switch response.result {
               case .success(let pdfUrlString):
                   print("Received response string: \(pdfUrlString)")
                   self.loadPDF(from: pdfUrlString)
                   
               case .failure(let error):
                   print("Failed to fetch PDF URL: \(error)")
               }
           }
       }
       
       private func loadPDF(from urlString: String) {
           guard let pdfURL = URL(string: urlString) else {
               print("Invalid PDF URL string: \(urlString)")
               return
           }
           
           print("Loading PDF from URL: \(pdfURL)")
           
           guard let pdfDocument = PDFDocument(url: pdfURL) else {
               print("Failed to create PDFDocument from URL: \(pdfURL)")
               return
           }
           
           let pdfView = PDFView(frame: view.bounds)
           pdfView.document = pdfDocument
           pdfView.autoScales = true
           
           view.addSubview(pdfView)
           
           pdfView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
           
           print("PDF loaded successfully and PDFView added to the view")
       }
   }
