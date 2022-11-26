//
//  SelectedNewsViewController.swift
//  News
//
//  Created by Aleksandr on 24.11.2022.
//

import UIKit
import SnapKit

protocol SelectedNewsViewInputProtocol: AnyObject {
    func displayNewsName(with title: String)
    func displayNewsContent(with title: String)
    func displayImage(with imageData: Data)
}

protocol SelectedNewsViewOutputProtocol {
    init(view: SelectedNewsViewInputProtocol)
    func showNews()
    func readMoreButtonPressed()
}

class SelectedNewsViewController: UIViewController {
    
//    var news: News!
    
    var presenter: SelectedNewsViewOutputProtocol!
    
//    private let configurator: SelectedNewsConfiguratorInputProtocol = SelectedNewsConfigurator()
    
    private lazy var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        newsImage.layer.cornerRadius = newsImage.frame.height / 2
        newsImage.clipsToBounds = true
        return newsImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 26)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = .systemFont(ofSize: 18)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .systemFont(ofSize: 18)
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .right
        return authorLabel
    }()
    
    private lazy var readMore: UIButton = {
        let readMore = UIButton(type: .system)
        readMore.setTitle("Read more...", for: .normal)
        readMore.addTarget(self, action: #selector(readMoreAction), for: .touchUpInside)
        
        return readMore
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save News",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        
//        configurator.configure(with: self, and: news)
        presenter.showNews()

        layout()
        
    }
    
    private func layout() {
        view.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(200)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(readMore)
        readMore.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
    }
    
//    private func getImage() {
//        guard let url = URL(string: news.imageUrl ?? "") else { return }
//        NetworkManager.shared.fetchImage(from: url) { result in
//            switch result {
//            case .success(let imageData):
//                self.newsImage.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
    @objc func readMoreAction() {
//        presenter.readMoreButtonPressed()
//        let newsUrl = news.readMoreUrl
//        let newsWebVC = NewsWebViewController()
//        newsWebVC.newsUrl = newsUrl
//        navigationController?.pushViewController(newsWebVC, animated: true)
    }
    
    @objc func addButtonTapped() {
//        StorageManager.shared.save(news: news)
//        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "News Saved", message: "This news saved in favorites list", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
        
    }
}

// MARK: - SelectedNewsViewInputProtocol

extension SelectedNewsViewController: SelectedNewsViewInputProtocol {
    func displayImage(with imageData: Data) {
        newsImage.image = UIImage(data: imageData)
    }
    
    func displayNewsContent(with title: String) {
        contentLabel.text = title
    }
    
    func displayNewsName(with title: String) {
        nameLabel.text = title
    }
    
    
}


