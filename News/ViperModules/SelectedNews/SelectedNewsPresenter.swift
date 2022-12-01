//
//  SelectedNewsPresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct SelectedNewsData {
    let title: String
    let content: String
    let imageData: Data
    let author: String
}

class SelectedNewsPresenter {
    weak var view: SelectedNewsViewInputProtocol?
    
    private let interactor: SelectedNewsInteractorInputProtocol
    private var selectedNewsData: SelectedNewsData?
    private let news: News
    
    init(interactor: SelectedNewsInteractorInputProtocol, news: News) {
        self.interactor = interactor
        self.news = news
    }
}

// MARK: - SelectedNewsViewOutputProtocol
extension SelectedNewsPresenter: SelectedNewsViewOutputProtocol {
    func showNews() {
        interactor.provideImageData(imageUrl: news.imageUrl)
    }
    
    func saveNewsButtonPressed() {
        interactor.saveSelectedNews(news: news)
    }
}

// MARK: - SelectedNewsInteractorOutputProtocol
extension SelectedNewsPresenter: SelectedNewsInteractorOutputProtocol {
    func receiveSelectedNewsData(with imageData: Data?){
        guard let imageData = imageData else { return }
        let data = SelectedNewsData(
            title: news.title ?? "",
            content: news.content ?? "",
            imageData: imageData,
            author: news.author ?? ""
        )
        view?.display(with: data)
    }
}
