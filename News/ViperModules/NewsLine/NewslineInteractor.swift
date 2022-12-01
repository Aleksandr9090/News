//
//  NewslineInteractor.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol NewslineInteractorInputProtocol {
    func fetchNewsline(with categoryUrl: String)
}

protocol NewslineInteractorOutputProtocol: AnyObject {
    func newslineDidRecive(with newslineData: NewslineData?)
}

class NewslineInteractor: NewslineInteractorInputProtocol {
    weak var presenter: NewslineInteractorOutputProtocol?
    
    func fetchNewsline(with categoryUrl: String) {
        NetworkManager.shared.fetchData(from: categoryUrl) { [weak self] newsPage in
            let newslineData = NewslineData(news: newsPage.data)
            self?.presenter?.newslineDidRecive(with: newslineData)
        }
    }
    
}
