//
//  Color.swift
//  
//
//  Created by Aleksandr on 08.12.2022.
//

import UIKit

enum Color {
    case primary
    case secondary
}

extension Color {
    var value: UIColor {
        get {
            switch self {
            case .primary :
                return UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1)
            case .secondary:
                return UIColor(red: 220/255, green: 251/255, blue: 255/255, alpha: 1)
            }
        }
    }
}

