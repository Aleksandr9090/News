//
//  ImageManager.swift
//  News
//
//  Created by Aleksandr on 23.11.2022.
//

import Foundation
//import UIKit

class ImageManager {
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImageData(from url: String?) -> Data? {
        
        guard let url = URL(string: url ?? "") else { return nil }
        guard let imageData = try? Data(contentsOf: url) else { return nil }
        return imageData
    }
//
//    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(data))
//            }
//        }.resume()
//    }
}

