//
//  SelectedNewsPresenter.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

struct SelectedNewsData {
    
}

class SelectedNewsPresenter: SelectedNewsViewOutputProtocol {
    unowned private let view: SelectedNewsViewInputProtocol
    
    var interactor: SelectedNewsInteractorInputProtocol!
    
    required init(view: SelectedNewsViewInputProtocol) {
        self.view = view
    }
    
    func showNews() {
        
    }
    
    
}

// MARK: - SelectedNewsInteractorOutputProtocol

extension SelectedNewsPresenter: SelectedNewsInteractorOutputProtocol {
    
}
