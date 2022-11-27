//
//  NewsCellViewModel.swift
//  News
//
//  Created by Aleksandr on 26.11.2022.
//

import Foundation

protocol NewsCellViewModelProtocol {
    var cellIdentifier: String { get }
    var cellHeght: Double { get }
    var newsTitle: String { get }
    var newsDate: String { get }
    var imageUrl: URL? { get }
    init(news: News)
}

protocol NewsSectionViewModelProtocol {
    var rows: [NewsCellViewModelProtocol] { get }
    func numberOfRows() -> Int
}

class NewsCellViewModel: NewsCellViewModelProtocol {
    var cellIdentifier: String {
        "newsCell"
    }
    
    var cellHeght: Double {
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
    
    private let news: News
    
    required init(news: News) {
        self.news = news
    }
}

class NewsSectionViewModel: NewsSectionViewModelProtocol {
    var rows: [NewsCellViewModelProtocol] = []
    
    func numberOfRows() -> Int {
        rows.count
    }
}
