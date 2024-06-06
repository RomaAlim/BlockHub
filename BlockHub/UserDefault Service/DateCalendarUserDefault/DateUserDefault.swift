//
//  DateUserDefault.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 07.06.2024.
//

import Foundation

struct CourseRegistration: Codable {
    var courseId: String
    var registrationDate: Date
    var deadlineDate: Date
    var completionDate: Date?
}


class CourseManager {
    static let shared = CourseManager()

    private init() {}

    func saveRegistration(courseId: String) {
        let calendar = Calendar.current
        let registrationDate = Date()
        let deadlineDate = calendar.date(byAdding: .day, value: 7, to: registrationDate)!
        let completionDate = calendar.date(byAdding: .day, value: 10, to: deadlineDate)!
        
        var registrations = loadRegistrations()
        registrations.append(CourseRegistration(courseId: courseId, registrationDate: registrationDate, deadlineDate: deadlineDate, completionDate: completionDate))
        saveRegistrations(registrations)
    }

    func loadRegistrations() -> [CourseRegistration] {
        guard let data = UserDefaults.standard.data(forKey: "courseRegistrations"),
              let registrations = try? JSONDecoder().decode([CourseRegistration].self, from: data) else {
            return []
        }
        return registrations
    }

    func deleteAllRegistrations() {
        UserDefaults.standard.removeObject(forKey: "courseRegistrations")
    }

    // Измените уровень доступа на internal или public
    internal func saveRegistrations(_ registrations: [CourseRegistration]) {
        guard let data = try? JSONEncoder().encode(registrations) else { return }
        UserDefaults.standard.set(data, forKey: "courseRegistrations")
    }
}
