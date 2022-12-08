//
//  FavoriteNewsViewController.swift
//  News
//
//  Created by Aleksandr on 25.11.2022.
//

import UIKit
import SnapKit

final class FavoriteNewsViewController: UIViewController {
    
    weak var delegate: FavoriteViewControllerDelegate?
        
    var favoriteNews: FavoriteNews?

    private var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        newsImage.layer.cornerRadius = newsImage.frame.height / 2
        newsImage.clipsToBounds = true
        return newsImage
    }()
    
    private var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    private var authorLabel: UILabel = {
        let authorLabel = UILabel()
        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.numberOfLines = 0
        authorLabel.textAlignment = .right
        return authorLabel
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        layout()
    }
    
    // MARK: - PrivateMethods
    @objc private func deleteButtonTapped() {
        StorageManager.shared.delete(favoriteNews)
        delegate?.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
    private func configure() {
        nameLabel.text = favoriteNews?.title
        contentLabel.text = favoriteNews?.content
        authorLabel.text = favoriteNews?.author
        
        view.addVerticalGradientLayer(
            topColor: Color.primary.value,
            bottomColor: Color.secondary.value
        )
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Delete",
            style: .plain,
            target: self,
            action: #selector(deleteButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .red
        
        getImage()
    }
    
    private func layout() {
        newsImageAddSubview()
        nameLabelAddSubview()
        contentLabelAddSubview()
        authorLabelAddSubview()
    }
    
    private func newsImageAddSubview() {
        view.addSubview(newsImage)
        
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(-40)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(150)
        }
    }
    
    private func nameLabelAddSubview() {
        view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(newsImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(80)
        }
    }
    
    private func contentLabelAddSubview() {
        view.addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func authorLabelAddSubview() {
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
