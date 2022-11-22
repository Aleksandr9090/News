//
//  NewslineCell.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

import Foundation
import UIKit
import SnapKit

class NewslineCell: UITableViewCell {
    static let identifier = "newslineCell"
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "sad"
        return nameLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "date"
//        dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
        return dateLabel
    }()
    
    private let newsImage: UIImageView = {
        let newsImage = UIImageView()
        newsImage.contentMode = .scaleAspectFit
        newsImage.layer.cornerRadius = newsImage.frame.height / 2
        newsImage.clipsToBounds = true
        return newsImage
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .systemGray5
        contentView.addSubview(nameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: News) {
        nameLabel.text = news.title
        dateLabel.text = news.date
        
        NetworkManager.shared.fetchImage(from: news.imageUrl) { imageData in
            self.newsImage.image = UIImage(data: imageData)
        }
        
//        NetworkManager.shared.fetchImage(from: news.imageUrl ?? "") { result in
//            switch result {
//            case .success(let imageData):
//                self.newsImage.image = UIImage(data: imageData)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        dateLabel.text = nil
//        newsImage.image = UIImage(systemName: "plus")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.addSubview(newsImage)
        newsImage.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(6)
            make.width.equalTo(contentView.frame.height)
            make.height.equalTo(contentView.frame.height)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(newsImage.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(contentView.frame.height * 2 / 3)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(newsImage.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(contentView.frame.height / 3)
        }
        
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
        
   
}
