//
//  CategoriesPresenter.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation
struct CategoriesData {
    
}

class CategoriesPresenter: CategoriesViewOutputProtocol {
    unowned private let view: CategoriesViewInputProtocol
//    var interactor = CategoriesInteractorInputProtocol
    
    required init(view: CategoriesViewInputProtocol) {
        self.view = view
    }
    
    func didTapCell() {
//        interactor.provide
    }
    
}

// MARK: - CategoriesInteractorOutputProtocol
extension CategoriesPresenter: CategoriesInteractorOutputProtocol {
    func receiveCategoriesData(_ categories: CategoriesData) {
//        let categories =
//        view.
    }
    
    
}
