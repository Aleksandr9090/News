//
//  FavoriteNewsCellModel.swift
//  News
//
//  Created by Aleksandr on 27.11.2022.
//

import Foundation

protocol FavoriteNewsCellViewModelProtocol {
    var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var newsTitle: String { get }
    var newsDate: String { get }
    var imageUrl: URL? { get }
    init(news: FavoriteNews)
}

protocol FavoriteNewsSectionViewModelProtocol {
    var rows: [FavoriteNewsCellViewModelProtocol] { get }
    func numberOfRows() -> Int
}

class FavoriteNewsCellViewModel: FavoriteNewsCellViewModelProtocol {
    var cellIdentifier: String {
        "favoriteNewsCell"
    }
    
    var cellHeight: Double {
        115
    }
    
    var newsTitle: String {
        news.title ?? ""
    }
    
    var newsDate: String {
        news.date ?? ""
    }
    
    var imageUrl: URL? {
        URL(string: news.imageUrl ?? "")
    }
    
    private let news: FavoriteNews
    
    required init(news: FavoriteNews) {
        self.news = news
    }
}

class FavoriteNewsSectionViewModel: FavoriteNewsSectionViewModelProtocol {
    var rows: [FavoriteNewsCellViewModelProtocol] = []
    
    func numberOfRows() -> Int {
        rows.count
    }
}
