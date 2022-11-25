//
//  NewslineConfigurator.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol NewslineConfiguratorInputProtocol {
    func configure( with viewController: NewslineViewController, and categoryUrl: String)
}

class NewslineConfigurator: NewslineConfiguratorInputProtocol {
    func configure(with viewController: NewslineViewController, and categoryUrl: String) {
        let presenter = NewslinePresenter(view: viewController)
        let interactor = NewslineInteractor(presenter: presenter, categoryUrl: categoryUrl)
        let router = NewslineRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
        
    }
}


