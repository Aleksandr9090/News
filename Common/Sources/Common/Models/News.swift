//
//  News.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

struct NewsPage: Codable {
    let data: [News]?
}

struct News: Codable {
    let author: String?
    let content: String?
    let date: String?
    let imageUrl: String?
    let readMoreUrl: String?
    let title: String?
}


