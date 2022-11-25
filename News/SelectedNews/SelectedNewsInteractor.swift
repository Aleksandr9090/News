//
//  SelectedNewsInteractor.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol SelectedNewsInteractorInputProtocol {
    init(presenter: SelectedNewsInteractorOutputProtocol, news: News)
}

protocol SelectedNewsInteractorOutputProtocol: AnyObject {
    
}

class SelectedNewsInteractor: SelectedNewsInteractorInputProtocol {
    unowned private let presenter: SelectedNewsInteractorOutputProtocol
    private let news: News
    
    required init(presenter: SelectedNewsInteractorOutputProtocol, news: News) {
        self.presenter = presenter
        self.news = news
    }
    
    
}
