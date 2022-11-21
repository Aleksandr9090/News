//
//  CategoriesViewController.swift
//  News
//
//  Created by Aleksandr on 19.11.2022.
//

import UIKit

protocol CategoriesViewInputProtocol: AnyObject {
    func setCategories()
}

protocol CategoriesViewOutputProtocol {
    init (view: CategoriesViewInputProtocol)
    func didTapCell()
}

class CategoriesViewController: UITableViewController {
    var presenter: CategoriesViewOutputProtocol!
//    private let configurator: CategoriesConfiguratorInputProtocol = CategoriesConfigurator()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
//        configurator.configure(withView: self)
    }
    
    private func setupNavigationBar() {
        title = "News Сategories"
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }


}

// MARK: - CategoriesViewInputProtocol
extension CategoriesViewController: CategoriesViewInputProtocol {
    func setCategories() {
        
    }
    
    
}
