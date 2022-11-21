//
//  CategoriesInteractor.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

protocol  CategoriesInteractorInputProtocol: AnyObject {
    init(presenter: CategoriesInteractorOutputProtocol)
    func provideCategoriesData()
}

protocol CategoriesInteractorOutputProtocol: AnyObject {
    func receiveCategoriesData(_ categories: CategoriesData)
}

class CategoriesInteractor: CategoriesInteractorInputProtocol {
    unowned private let presenter: CategoriesInteractorOutputProtocol
    
    required init(presenter: CategoriesInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func provideCategoriesData() {
        //let categories = 
    }
    
    
}
