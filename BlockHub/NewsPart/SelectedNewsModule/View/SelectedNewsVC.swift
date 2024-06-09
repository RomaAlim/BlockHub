//
//  SelectedNewsVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import UIKit

class SelectedNewsVC: UIViewController {

    
    @IBOutlet weak var nameNewsLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var bodyTextTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var newsId: Int?
        var newsItem: News?

        override func viewDidLoad() {
            super.viewDidLoad()
            fetchNews()
            updateUI()
        }

        private func fetchNews() {
            guard let id = newsId else { return }
            NewsService.shared.fetchNews(by: id) { result in
                switch result {
                case .success(let newsItem):
                    self.newsItem = newsItem
                    self.configureView()
                case .failure(let error):
                    print("Failed to fetch news:", error)
                }
            }
        }

        private func configureView() {
            guard let newsItem = newsItem else { return }
            
            nameNewsLabel.text = newsItem.title
            subTitleLabel.text = newsItem.subtitle
            bodyTextTextView.text = newsItem.content
            dateLabel.text = formatDate(newsItem.datePublished)
            
            if let imageUrl = URL(string: newsItem.imageKey) {
                loadImage(from: imageUrl) { image in
                    DispatchQueue.main.async {
                        self.imageViewNews.image = image
                    }
                }
            }
        }

        private func formatDate(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                return dateFormatter.string(from: date)
            }
            
            return dateString
        }

        private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    completion(image)
                } else {
                    completion(nil)
                }
            }.resume()
        }
   func updateUI(){
       bodyTextTextView.isEditable = false
       bodyTextTextView.isSelectable = true
       bodyTextTextView.isUserInteractionEnabled = true
    }
    }
