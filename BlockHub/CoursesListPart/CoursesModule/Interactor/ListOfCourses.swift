//
//  ListOfCourses.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//
import Foundation

struct Course: Codable {
    let id: Int
    let name: String
    let description: String
    let imageKey: String
    let dateCreated: String
    let dateUpdated: String
    let durationInMonths: Int
    let level: String
    let language: String
    let modules: [CourseModule]
    let skills: [Skill]
}

struct CourseModule: Codable {
    let id: Int
    let title: String
    let lessons: [Lesson]
    let moduleTest: ModuleTest?
}

struct Lesson: Codable {
    let id: Int
    let title: String
    let contentType: String
    let fileKey: String
}

struct ModuleTest: Codable {
    let id: Int?
    let testName: String?
    let questions: [TestQuestion]?

    enum CodingKeys: String, CodingKey {
        case id
        case testName = "testName"
        case questions = "questions"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        testName = try? container.decode(String.self, forKey: .testName)
        questions = try? container.decode([TestQuestion].self, forKey: .questions)
    }
}

struct TestQuestion: Codable {
    let id: Int?
    let questionText: String?
    let options: [QuestionOption]?

    enum CodingKeys: String, CodingKey {
        case id
        case questionText = "questionText"
        case options = "options"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        questionText = try? container.decode(String.self, forKey: .questionText)
        options = try? container.decode([QuestionOption].self, forKey: .options)
    }
}

struct QuestionOption: Codable {
    let id: Int?
    let optionText: String?
    let isCorrect: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case optionText = "optionText"
        case isCorrect = "isCorrect"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        optionText = try? container.decode(String.self, forKey: .optionText)
        isCorrect = try? container.decode(Bool.self, forKey: .isCorrect)
    }
}

struct TestSubmission: Codable {
    let id: Int
    let user: User
    let score: Int
    let totalQuestions: Int
    let passed: Bool
    let submissionDate: String
}

struct User: Codable {
    let id: Int
    let username: String
    let email: String
    let password: String
    let roles: [Role]
}

struct Role: Codable {
    let name: String
}

struct Skill: Codable {
    let id: Int
    let skillDescription: String
}
