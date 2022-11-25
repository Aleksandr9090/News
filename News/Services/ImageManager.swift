//
//  ImageManager.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import Foundation

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from urlString: String?) -> Data? {
        guard let urlString = urlString else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
}
