//
//  NewslineInteractor.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol NewslineInteractorInputProtocol {
    func fetchNewsline()
}

protocol NewslineInteractorOutputProtocol: AnyObject {
    func newslineDidRecive(with newslineData: NewslineData?)
}

class NewslineInteractor: NewslineInteractorInputProtocol {
    weak var presenter: NewslineInteractorOutputProtocol?
    private let categoryUrl: String?
    
    init(categoryUrl: String) {
        self.categoryUrl = categoryUrl
    }
    
    func fetchNewsline() {
        NetworkManager.shared.fetchData(from: categoryUrl) { [weak self] newsPage in
            let newslineData = NewslineData(news: newsPage.data)
            self?.presenter?.newslineDidRecive(with: newslineData)
        }
    }
    
}
