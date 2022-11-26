//
//  ImageCache.swift
//  News
//
//  Created by Aleksandr on 22.11.2022.
//

import Foundation
import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
