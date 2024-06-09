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
    let id: Int
    let testName: String
    let questions: [TestQuestion]
}

struct TestQuestion: Codable {
    let id: Int
    let questionText: String
    let options: [QuestionOption]
}

struct QuestionOption: Codable {
    let id: Int
    let optionText: String
    let isCorrect: Bool
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
