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

final class SelectedNewsConfigurator: SelectedNewsConfiguratorInputProtocol {
    func configure(with viewController: SelectedNewsViewController, and news: News) {
        let interactor = SelectedNewsInteractor()
        let presenter = SelectedNewsPresenter(interactor: interactor, news: news)
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
    }
}
