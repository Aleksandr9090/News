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
        let interactor = NewslineInteractor(categoryUrl: categoryUrl)
        let router = NewslineRouter()
        let presenter = NewslinePresenter(interactor: interactor, router: router)
        
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.viewController = viewController
    }
}


