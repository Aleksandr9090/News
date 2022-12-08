//
//  NetworkManager.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation

final class NetworkManager {

    static let shared  = NetworkManager()

    private init() {}
    
    func fetchNewsPage(from url: String?, with completion: @escaping(Result<NewsPage, NetworkError>) -> Void) {
        guard let url = URL(string: url ?? "") else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let newsPage = try JSONDecoder().decode(NewsPage.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(newsPage))
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        fetchData(from: url, completion: completion)
    }
    
    func fetchImage(from urlString: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString ?? "") else { return }
        fetchData(from: url, completion: completion)
    }
    
    private func fetchData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
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
