//
//  CategoriesConfigurator.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

protocol CategoriesConfiguratorInputProtocol {
    func configure(withView viewController: CategoriesViewController)
}

class CategoriesConfigurator: CategoriesConfiguratorInputProtocol {
    func configure(withView viewController: CategoriesViewController) {
        let presenter = CategoriesPresenter(view: viewController)
        let interactor = CategoriesInteractor(presenter: presenter)
        let router = CategoriesRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
