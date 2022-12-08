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

final class CategoriesConfigurator: CategoriesConfiguratorInputProtocol {
    func configure(withView view: CategoriesViewController) {
        let interactor = CategoriesInteractor()
        let router = CategoriesRouter()
        let presenter = CategoriesPresenter(interactor: interactor, router: router)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        router.viewController = view
    }
}
