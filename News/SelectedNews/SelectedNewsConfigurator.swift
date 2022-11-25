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
        let presenter = SelectedNewsPresenter(view: viewController)
        let interactor = SelectedNewsInteractor(presenter: presenter, news: news)
        let router = SelectedNewsRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
    }
}


