//
//  SelectedNewsInteractor.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol SelectedNewsInteractorInputProtocol {
    func provideImageData(imageUrl: String?)
    func saveSelectedNews(news: News)
}

protocol SelectedNewsInteractorOutputProtocol: AnyObject {
    func selectedNewsDidReceive(with imageData: Data?)
}

final class SelectedNewsInteractor: SelectedNewsInteractorInputProtocol {
    weak var presenter: SelectedNewsInteractorOutputProtocol?
    
    func saveSelectedNews(news: News) {
        StorageManager.shared.save(news: news)
    }
    
    func provideImageData(imageUrl: String?) {
        let imageData = ImageManager.shared.fetchImageData(from: imageUrl)
        presenter?.selectedNewsDidReceive(with: imageData)
    }
}
