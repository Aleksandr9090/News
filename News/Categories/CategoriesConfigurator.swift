//
//  CategoriesConfigurator.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

protocol CategoriesConfiguratorInputProtocol {
    func configure(withView view: CategoriesViewController)
}

class CategoriesConfigurator: CategoriesConfiguratorInputProtocol {
    func configure(withView view: CategoriesViewController) {
        let presenter = CategoriesPresenter(view: view)
        let interactor = CategoriesInteractor(presenter: presenter)
        let router = CategoriesRouter(viewController: view)
        
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
