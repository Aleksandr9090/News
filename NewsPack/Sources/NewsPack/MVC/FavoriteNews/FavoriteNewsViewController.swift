//
//  FavoriteNewsViewController.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import UIKit
import SnapKit

class FavoriteNewsViewController: UIViewController {
    
    var delegate: FavoriteViewControllerDelegate?
        
    var favoriteNews: FavoriteNews?
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .red

        configure()
        layout()
    }
    
    @objc func deleteButtonTapped() {
        StorageManager.shared.delete(favoriteNews)
        delegate?.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func configure() {
        nameLabel.text = favoriteNews?.title
        contentLabel.text = favoriteNews?.content
        authorLabel.text = favoriteNews?.author
        
        getImage()
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
    
    private func getImage() {
        guard let url = URL(string: favoriteNews?.imageUrl ?? "") else { return }
        NetworkManager.shared.fetchImage(from: url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.newsImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
