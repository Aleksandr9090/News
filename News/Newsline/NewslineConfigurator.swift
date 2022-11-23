//
//  NewslineConfigurator.swift
//  News
//
//  Created by Aleksandr on 22.11.2022.
//

import Foundation

protocol NewslineConfiguratorInputProtocol {
    func configure(with viewController: NewslineViewController, and category: String)
}

class NewslineConfigurator: NewslineConfiguratorInputProtocol {
    func configure(with viewController: NewslineViewController, and category: String) {
        let presenter = NewslinePresenter(view: viewController)
        let interactor = NewslineInteractor(presenter: presenter, category: category)
        viewController.presenter = presenter
        presenter.interactor = interactor
    }
}
