//
//  SelectedNewsViewController.swift
//  News
//
//  Created by Aleksandr on 24.11.2022.
//

import UIKit
import SnapKit

protocol SelectedNewsViewInputProtocol: AnyObject {
    func display(with data: SelectedNewsData)
}

protocol SelectedNewsViewOutputProtocol {
    func showNews()
    func saveNewsButtonPressed()
}

class SelectedNewsViewController: UIViewController {
        
    var presenter: SelectedNewsViewOutputProtocol?
    
    private let primaryColor = UIColor(
        red: 242/255,
        green: 242/255,
        blue: 247/255,
        alpha: 1
    )
    
    private let secondaryColor = UIColor(
        red: 220/255,
        green: 251/255,
        blue: 255/255,
        alpha: 1
    )
        
    private lazy var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        newsImage.layer.cornerRadius = newsImage.frame.height / 2
        newsImage.clipsToBounds = true
        return newsImage
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    private lazy var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .right
        return authorLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save News",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        presenter?.showNews()
        layout()
    }
    
    private func layout() {
        view.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(150)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
        
        view.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        view.addSubview(authorLabel)
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc func addButtonTapped() {
        presenter?.saveNewsButtonPressed()
        showAlert()
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
    func display(with data: SelectedNewsData) {
        authorLabel.text = data.author
        newsImage.image = UIImage(data: data.imageData)
        contentLabel.text = data.content
        nameLabel.text = data.title
    }
}



