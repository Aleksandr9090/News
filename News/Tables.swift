//
//  Tables.swift
//  News
//
//  Created by Aleksandr on 28.11.2022.
//

import UIKit

/// Поставщик-перечисление, необходимый, чтобы обеспечить animationTitle и получить метод анимации из фабрики
enum TableAnimation {
    case fadeIn(duration: TimeInterval, delay: TimeInterval)
    case moveUp(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpBounce(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    
    // обеспечивает необходимую длительность и задержку анимации в зависимости от конкретного варианта
    func getAnimation() -> TableCellAnimation {
        switch self {
        case .fadeIn(let duration, let delay):
            return TableAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        case .moveUp(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpAnimation(rowHeight: rowHeight, duration: duration,
                                                             delayFactor: delay)
        case .moveUpWithFade(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpWithFadeAnimation(rowHeight: rowHeight, duration: duration,
                                                                     delayFactor: delay)
        case .moveUpBounce(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: rowHeight, duration: duration,
                                                                   delayFactor: delay)
        }
    }
    
//    // предоставляет заголовок в зависимости от варианта
//    func getTitle() -> String {
//        switch self {
//        case .fadeIn(_, _):
//            return "Fade-In Animation"
//        case .moveUp(_, _, _):
//            return "Move-Up Animation"
//        case .moveUpWithFade(_, _, _):
//            return "Move-Up-Fade Animation"
//        case .moveUpBounce(_, _, _):
//            return "Move-Up-Bounce Animation"
//        }
//    }
}
