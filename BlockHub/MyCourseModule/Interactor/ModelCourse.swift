//
//  ModelCourse.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//

import Foundation

struct MyCourse {
    let name: String
    let numberOfLessons: Int
    let completedLessons: Int
    var progress: Float {
        return Float(completedLessons) / Float(numberOfLessons)
    }
}

let Mycourses = [
    MyCourse(name: "Blockchain BASICS", numberOfLessons: 64, completedLessons: 62),
    MyCourse(name: "Blockchain ADVANCED", numberOfLessons: 50, completedLessons: 45),
    MyCourse(name: "Smart Contracts", numberOfLessons: 40, completedLessons: 30),
    // Добавьте остальные курсы
]
