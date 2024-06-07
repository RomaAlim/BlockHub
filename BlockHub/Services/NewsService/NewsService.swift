//
//  NewsService.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 08.06.2024.
//

import Foundation
import Alamofire

class NewsService {
    static let shared = NewsService()
    private let baseURL = "https://educationplatform-juhi.onrender.com/api/v1/news"

    private init() {}

    func fetchAllNews(completion: @escaping (Result<[News], Error>) -> Void) {
        let url = "\(baseURL)/all"
        AF.request(url, method: .get, headers: ["accept": "*/*"]).responseDecodable(of: [News].self) { response in
            switch response.result {
            case .success(let news):
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
