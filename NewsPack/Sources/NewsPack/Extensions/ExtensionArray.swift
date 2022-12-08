//
//  Extensions.swift
//  News
//
//  Created by Aleksandr on 04.12.2022.
//

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index >= 0 && index < endIndex) ? self[index] : nil
    }
}
