//
//  NewsCellViewModel.swift
//  News
//
//  Created by Aleksandr on 26.11.2022.
//

protocol NewsCellViewModelProtocol {
    static var cellIdentifier: String { get }
    var cellHeight: Double { get }
    var newsTitle: String { get }
    var newsDate: String { get }
    var imageUrl: String { get }
    init(news: News)
}

protocol NewsSectionViewModelProtocol {
    var rows: [NewsCellViewModelProtocol] { get }
    func numberOfRows() -> Int
}

final class NewsCellViewModel: NewsCellViewModelProtocol {
    static var cellIdentifier: String {
        "newsCell"
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
    
    var imageUrl: String {
        news.imageUrl ?? ""
    }
    
    private let news: News
    
    required init(news: News) {
        self.news = news
    }
}

final class NewsSectionViewModel: NewsSectionViewModelProtocol {
    var rows: [NewsCellViewModelProtocol] = []
    
    func numberOfRows() -> Int {
        rows.count
    }
}
