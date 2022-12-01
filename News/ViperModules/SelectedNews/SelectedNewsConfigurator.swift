//
//  SelectedNewsConfigurator.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol SelectedNewsConfiguratorInputProtocol {
    func configure( with viewController: SelectedNewsViewController, and news: News)
}

class SelectedNewsConfigurator: SelectedNewsConfiguratorInputProtocol {
    func configure(with viewController: SelectedNewsViewController, and news: News) {
        let interactor = SelectedNewsInteractor(news: news)
        let presenter = SelectedNewsPresenter(interactor: interactor)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
    }
}


