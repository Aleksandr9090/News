//
//  NewslineCell.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation
import UIKit
import SnapKit

protocol CellModelRepresentable {
    var viewModel: NewsCellViewModelProtocol? { get }
}

class NewsCell: UITableViewCell, CellModelRepresentable {
    var viewModel: NewsCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
                
        return activityIndicator
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        return dateLabel
    }()
    
    private lazy var newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        return newsImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        dateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(6)
            make.width.equalTo(contentView.frame.height-8)
            make.height.equalTo(contentView.frame.height-8)
        }
        
        contentView.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.width.equalTo(contentView.frame.height-8)
            make.height.equalTo(contentView.frame.height-8)
            
            newsImage.layer.cornerRadius = newsImage.frame.height / 2
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(newsImage.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(newsImage.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(contentView.frame.height / 3)
        }
    }
    
    private func updateView(){
        guard let viewModel = viewModel as? NewsCellViewModel else { return }
        
        nameLabel.text = viewModel.newsTitle
        dateLabel.text = viewModel.newsDate
        
        if let imageUrl = viewModel.imageUrl {
            NetworkManager.shared.fetchImage(from: imageUrl) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.newsImage.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
