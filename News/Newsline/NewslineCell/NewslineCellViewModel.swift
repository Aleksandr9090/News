//
//  NewslineCellViewModel.swift
//  News
//
//  Created by Aleksandr on 23.11.2022.
//

import Foundation

protocol NewslineCellViewModelProtocol {
    var cellIdetifier: String { get }
    var cellHeight: Double { get }
    var newsTitle: String { get }
    var newsDate: String { get }
    var imageData: Data? { get }
    init(news: News)
}

protocol NewslineSectionViewModelProtocol {
    var rows: [NewslineCellViewModelProtocol] { get }
    func numberOfRows() -> Int
}

class NewslineCellViewModel: NewslineCellViewModelProtocol {
    var cellIdetifier: String {
        "newslineCell"
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
    
    var imageData: Data? {
        ImageManager.shared.fetchImageData(from: news.imageUrl)
    }
    
    private let news: News
    
    required init(news: News) {
        self.news = news
    }
}

class NewslineSectionViewModel: NewslineSectionViewModelProtocol {
    var rows: [NewslineCellViewModelProtocol] = []
    
    func numberOfRows() -> Int {
        rows.count
    }
}
