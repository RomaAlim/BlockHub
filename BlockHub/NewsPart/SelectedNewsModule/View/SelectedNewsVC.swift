//
//  SelectedNewsVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import UIKit
import PDFKit

class SelectedNewsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPDFViewNews()
    }
    
    private func setupPDFViewNews() {
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
        

    }