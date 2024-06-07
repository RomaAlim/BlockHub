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
    func updateUI(){
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
            cell.newsTitleTextView.text = "\(newsItem.title)\n\(newsItem.subtitle)"
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150 // Set the height for each cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let selectedNewsVC = storyboard.instantiateViewController(withIdentifier: "SelectedNewsVC") as? SelectedNewsVC {
                navigationController?.pushViewController(selectedNewsVC, animated: true)
            }
        }
    }
