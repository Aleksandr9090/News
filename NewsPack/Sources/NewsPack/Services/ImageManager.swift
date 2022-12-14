//
//  ImageManager.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

final class ImageManager {
    static let shared = ImageManager()

    private init() {}

    func fetchImageData(from urlString: String?) -> Data? {
        guard let urlString = urlString,
              let url = URL(string: urlString),
              let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
