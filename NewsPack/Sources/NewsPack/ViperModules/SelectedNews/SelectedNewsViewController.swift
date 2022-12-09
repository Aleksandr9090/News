//
//  SelectedNewsViewController.swift
//  News
//
//  Created by Aleksandr on 24.11.2022.
//

import UIKit
import SnapKit

protocol SelectedNewsViewInputProtocol: AnyObject {
    func display(with viewModel: SelectedNewsViewModel)
}

protocol SelectedNewsViewOutputProtocol {
    func showNews()
    func saveNewsButtonPressed()
}

final class SelectedNewsViewController: UIViewController {
        
    var presenter: SelectedNewsViewOutputProtocol?
        
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

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        presenter?.showNews()
        layout()
    }
    
    // MARK: - PrivateMethods
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
    
    private func configure() {
        view.addVerticalGradientLayer(
            topColor: Color.primary.value,
            bottomColor: Color.secondary.value
        )
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save News",
            style: .plain,
            target: self,
            action: #selector(addButtonTapped)
        )
    }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: "News Saved",
            message: "This news saved in favorites list", preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    @objc private func addButtonTapped() {
        presenter?.saveNewsButtonPressed()
        showAlert()
    }
}

// MARK: - SelectedNewsViewInputProtocol
extension SelectedNewsViewController: SelectedNewsViewInputProtocol {
    func display(with viewModel: SelectedNewsViewModel) {
        authorLabel.text = viewModel.author
        newsImage.image = UIImage(data: viewModel.imageData)
        contentLabel.text = viewModel.content
        nameLabel.text = viewModel.title
    }
}
