//
//  NewsView.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 31.05.2024.
//

import UIKit

class NewsView: UIViewController{

    @IBOutlet weak var NewsSearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var NewstextLabel: UILabel!
    
    var newsArray = [News]()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
            
            updateUI()
            fetchNews()
        }

        func updateUI() {
            let backButton = UIBarButtonItem()
            backButton.title = ""
            self.navigationItem.backBarButtonItem = backButton
            NewstextLabel.text = "blockhub_news".localized
        }

        private func fetchNews() {
            NewsService.shared.fetchAllNews { result in
                switch result {
                case .success(let news):
                    self.newsArray = news
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch news:", error)
                }
            }
        }

        private func getInitialViews(for newsId: Int) -> Int {
            let viewsKey = "news_\(newsId)_views"
            if let views = UserDefaults.standard.value(forKey: viewsKey) as? Int {
                return views
            } else {
                let initialViews = Int.random(in: 40...50)
                UserDefaults.standard.set(initialViews, forKey: viewsKey)
                return initialViews
            }
        }

        private func incrementViews(for newsId: Int) {
            let viewsKey = "news_\(newsId)_views"
            if var views = UserDefaults.standard.value(forKey: viewsKey) as? Int {
                views += 1
                UserDefaults.standard.set(views, forKey: viewsKey)
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
    }

    extension NewsView: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
                return UITableViewCell()
            }
            
            let newsItem = newsArray[indexPath.row]
            let views = getInitialViews(for: newsItem.id)
            let formattedDate = formatDate(newsItem.datePublished)
            
            let text = """
            \(newsItem.title)
            \(newsItem.subtitle)
            \(formattedDate)
            """
            cell.newsTitleTextView.text = text
            cell.viewsLabel.text = "\(views)"
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150 // Set the height for each cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let newsItem = newsArray[indexPath.row]
            incrementViews(for: newsItem.id)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let selectedNewsVC = storyboard.instantiateViewController(withIdentifier: "SelectedNewsVC") as? SelectedNewsVC {
                //selectedNewsVC.newsItem = newsItem
                navigationController?.pushViewController(selectedNewsVC, animated: true)
            }
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    }
