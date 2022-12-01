//
//  SelectedNewsPresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct SelectedNewsData {
    let title: String?
    let content: String?
    let imageData: Data?
    let author: String?
}

class SelectedNewsPresenter: SelectedNewsViewOutputProtocol {
    weak var view: SelectedNewsViewInputProtocol?
    
    private let interactor: SelectedNewsInteractorInputProtocol
    
    private var selectedNewsData: SelectedNewsData?
    
    init(interactor: SelectedNewsInteractorInputProtocol) {
        self.interactor = interactor
    }
    
    func showNews() {
        interactor.provideSelectedNews()
    }
    
    func saveNewsButtonPressed() {
        interactor.saveSelectedNews()
    }
}

// MARK: - SelectedNewsInteractorOutputProtocol

extension SelectedNewsPresenter: SelectedNewsInteractorOutputProtocol {
    func receiveSelectedNews(with selectedNewsData: SelectedNewsData) {
        view?.displayNewsName(with: selectedNewsData.title ?? "")
        view?.displayNewsContent(with: selectedNewsData.content ?? "")
        view?.displayNewsAuthor(with: selectedNewsData.author ?? "")
        guard let imageData = selectedNewsData.imageData else { return }
        view?.displayImage(with: imageData)
    }
}
