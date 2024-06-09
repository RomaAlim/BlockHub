//
//  ListAchievsVC.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import UIKit
import Alamofire

class ListAchievsVC: UIViewController {

    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var achiveTextLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var certificates: [Certificate] = []

        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
            
            fetchCertificates()
            updateUI()
            fetchProfileImage()
            displayUserData()
            self.view.backgroundColor = .link
        }
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
            personImageView.clipsToBounds = true
        }
        
        func updateUI(){
            achiveTextLabel.text = "achievements".localized
        }
        
        private func fetchProfileImage() {
            guard let token = TokenStorageService.shared.getToken() else {
                print("No token found")
                return
            }
            
            let url = URL(string: "https://educationplatform-juhi.onrender.com/api/v1/user/image")!
            var request = URLRequest(url: url)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                if let error = error {
                    print("Failed to fetch profile image: \(error)")
                    return
                }
                
                guard let data = data, let imageUrlString = String(data: data, encoding: .utf8), let imageUrl = URL(string: imageUrlString) else {
                    print("Invalid data or URL string")
                    return
                }
                
                URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                    if let error = error {
                        print("Failed to load image: \(error)")
                        return
                    }
                    
                    guard let data = data, let image = UIImage(data: data) else {
                        print("Failed to decode image data")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.personImageView.image = image
                    }
                }.resume()
            }.resume()
        }
        
        private func displayUserData() {
            let userDefaults = UserDefaults.standard
            if let name = userDefaults.string(forKey: "userName"){
                personNameLabel.text = name
            } else {
                personNameLabel.text = "Name: N/A"
            }
        }
        
        private func fetchCertificates() {
            guard let token = TokenStorageService.shared.getToken() else {
                print("No token found")
                return
            }
            
            let url = "https://educationplatform-juhi.onrender.com/api/v1/certificates/user-certificates"
            let headers: HTTPHeaders = [
                "Authorization": "Bearer \(token)",
                "Accept": "application/json"
            ]
            
            AF.request(url, headers: headers).responseDecodable(of: [Certificate].self) { response in
                switch response.result {
                case .success(let certificates):
                    self.certificates = certificates
                    self.tableView.reloadData()
                case .failure(let error):
                    print("Failed to fetch certificates: \(error)")
                }
            }
        }
    }

    extension ListAchievsVC: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return certificates.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell else {
                return UITableViewCell()
            }
            
            let certificate = certificates[indexPath.row]
            cell.achieveNameLabel.text = certificate.courseName
            cell.achieveDescriptionLabel.text = "Certificate"
            cell.achiveImageView.image = UIImage(systemName: "doc.text")
            cell.achiveImageView.tintColor = .black
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90 // Установите высоту для каждой ячейки
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let certificate = certificates[indexPath.row]
            if let url = URL(string: certificate.certificateUrl) {
                UIApplication.shared.open(url)
            }
        }
    }
