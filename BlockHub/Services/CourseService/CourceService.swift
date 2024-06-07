//
//  CourceService.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 08.06.2024.
//
import Foundation
import Alamofire

class CourseService {
    static let shared = CourseService()
    
    private let baseURL = "https://educationplatform-juhi.onrender.com/api/v1"
    private let coursesKey = "coursesKey"
    
    private init() {}
    
    func getAllCourses(completion: @escaping (Result<[Course], Error>) -> Void) {
        guard let token = TokenStorageService.shared.getToken() else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Unauthorized"])))
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "application/json"
        ]
        
        AF.request("\(baseURL)/courses/all", method: .get, headers: headers).responseDecodable(of: [Course].self) { response in
            switch response.result {
            case .success(let courses):
                self.saveCoursesToUserDefaults(courses)
                print("Fetched courses from backend:")
                for course in courses {
                    print("Course: \(course.name), Description: \(course.description), Duration: \(course.durationInMonths) months")
                }
                completion(.success(courses))
            case .failure(let error):
                print("Failed to fetch courses: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    func loadCoursesFromUserDefaults() -> [Course]? {
        if let data = UserDefaults.standard.data(forKey: coursesKey) {
            let decoder = JSONDecoder()
            return try? decoder.decode([Course].self, from: data)
        }
        return nil
    }
    
    private func saveCoursesToUserDefaults(_ courses: [Course]) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(courses) {
            UserDefaults.standard.set(data, forKey: coursesKey)
        }
    }
}
