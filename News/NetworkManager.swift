//
//  NetworkManager.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

class NetworkManager {
    
    static let shared  = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with completion: @escaping(NewsPage) -> Void) {
        guard let url = URL(string: url ?? "") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let NewsPage = try JSONDecoder().decode(NewsPage.self, from: data)
                DispatchQueue.main.async {
                    completion(NewsPage)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}




///
//    func fetchImage(from url: String?, with completion: @escaping(Data) -> Void) {
//        guard let stringUrl = url else { return }
//        guard let imageUrl = URL(string: stringUrl) else { return }
//        DispatchQueue.global().async {
//            guard let data = try? Data(contentsOf: imageUrl) else { return }
//            DispatchQueue.main.async {
//                completion(data)
//            }
//        }
//    }
//
//    func fetch<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
//        guard let url = URL(string: url) else {
//            completion(.failure(.invalidURL))
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let type = try decoder.decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(type))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
//    }
//
//
//    func fetchImage(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseData { response in
//                switch response.result {
//                case .success(let data):
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
//        }
//}

