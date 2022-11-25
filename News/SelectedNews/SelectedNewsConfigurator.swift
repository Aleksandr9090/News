//
//  SelectedNewsConfigurator.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

protocol SelectedNewsConfiguratorProtocol {
    func configure( with viewController: SelectedNewsViewController, and news: News)
}

class SelectedNewsconfigurator: SelectedNewsConfiguratorProtocol {
    func configure(with viewController: SelectedNewsViewController, and news: News) {
        let presenter = SelectedNewsPresenter(view: viewController)
        let interactor = SelectedNewsInteractor(presenter: presenter, news: news)
        viewController.presenter = presenter
        presenter.interactor = interactor
        
    }
}


