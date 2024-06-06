//
//  ModelCourse.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 03.06.2024.
//

struct MyCourse {
    let name: String
    let numberOfLessons: Int
    let completedLessons: Int
    var isPassed: Bool {
        return completedLessons == numberOfLessons
    }
}
