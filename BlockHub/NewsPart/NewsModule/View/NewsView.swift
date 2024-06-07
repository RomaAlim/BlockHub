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
    
    var newsArray = [
           News(id: 1, title: "News Title 1", description: "Description for news 1."),
           News(id: 2, title: "News Title 2", description: "Description for news 2."),
           News(id: 3, title: "News Title 3", description: "Description for news 3."),
           News(id: 4, title: "News Title 4", description: "Description for news 4."),
           News(id: 5, title: "News Title 5", description: "Description for news 5."),
           News(id: 6, title: "News Title 6", description: "Description for news 6."),
           News(id: 7, title: "News Title 7", description: "Description for news 7."),
           News(id: 8, title: "News Title 8", description: "Description for news 8."),
           News(id: 9, title: "News Title 9", description: "Description for news 9."),
           News(id: 10, title: "News Title 10", description: "Description for news 10."),
           News(id: 11, title: "News Title 11", description: "Description for news 11."),
           News(id: 12, title: "News Title 12", description: "Description for news 12.")
       ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsTableViewCell")
        NewstextLabel.text = "blockhub_news".localized
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
        cell.newsTitleTextView.text = newsItem.title
        
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
