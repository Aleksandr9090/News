//
//  News.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

struct NewsPage: Codable {
    let data: [News]?
    
    init(newsPageData: [String: Any]) {
        let data = newsPageData["data"] as? [[String: Any]] ?? []
        self.data = data.compactMap { News(newsData: $0) }
    }
    static func getNewsPage(from value: Any) -> NewsPage? {
        guard let data = value as? [String: Any] else { return nil }
        return NewsPage(newsPageData: data)
    }
}

struct News: Codable {
    let author: String?
    let content: String?
    let date: String?
    let imageUrl: String?
    let readMoreUrl: String?
    let title: String?
    
    init(newsData: [String: Any]) {
        author = newsData["author"] as? String
        content = newsData["content"] as? String
        date = newsData["date"] as? String
        imageUrl = newsData["imageUrl"] as? String
        readMoreUrl = newsData["readMoreUrl"] as? String
        title = newsData["title"] as? String
    }
}


