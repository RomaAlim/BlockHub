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

    func fetchNews(by id: Int, completion: @escaping (Result<News, Error>) -> Void) {
        guard let token = TokenStorageService.shared.getToken() else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Token not found"])))
            return
        }

        let url = "\(baseURL)/\(id)"
        let headers: HTTPHeaders = [
            "accept": "*/*",
            "Authorization": "Bearer \(token)"
        ]

        AF.request(url, method: .get, headers: headers).responseDecodable(of: News.self) { response in
            switch response.result {
            case .success(let news):
                completion(.success(news))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
