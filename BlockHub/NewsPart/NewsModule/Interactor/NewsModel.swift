//
//  NewsModel.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import Foundation

struct News: Codable{
    let id: Int
    let title: String
    let subtitle: String
    let content: String
    let datePublished: String
    let imageKey: String
}
