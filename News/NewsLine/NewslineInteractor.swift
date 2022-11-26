//
//  NewslineInteractor.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol NewslineInteractorInputProtocol {
    init(presenter: NewslineInteractorOutputProtocol, categoryUrl: String)
    func fetchNewsline()
}

protocol NewslineInteractorOutputProtocol: AnyObject {
    func newslineDidRecive(with newsLineData: NewslineData?)
}

class NewslineInteractor: NewslineInteractorInputProtocol {
    unowned private let presenter: NewslineInteractorOutputProtocol
    private let categoryUrl: String
    
    required init(presenter: NewslineInteractorOutputProtocol, categoryUrl: String) {
        self.presenter = presenter
        self.categoryUrl = categoryUrl
    }
    
    func fetchNewsline() {
        NetworkManager.shared.fetchData(from: categoryUrl) { [weak self] newsPage in
            let newslineData = NewslineData(news: newsPage.data)
            self?.presenter.newslineDidRecive(with: newslineData)
        }
    }
    
}
