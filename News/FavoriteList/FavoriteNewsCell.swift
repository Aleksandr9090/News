//
//  FavoriteNewsViewCell.swift
//  News
//
//  Created by Aleksandr on 27.11.2022.
//

import Foundation
import UIKit
import SnapKit

class FavoriteNewsCell: UITableViewCell {
        
    static let identifier = "newslineCell"
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
                
        return activityIndicator
    }()
    
    let newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with news: FavoriteNews) {
        nameLabel.text = news.title
        dateLabel.text = news.date
        
        NetworkManager.shared.fetchImage(from: news.imageUrl) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.newsImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
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
        
        contentView.addSubview(newsImageView)
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top).offset(4)
            make.leading.equalToSuperview().offset(6)
            make.width.equalTo(contentView.frame.height-8)
            make.height.equalTo(contentView.frame.height-8)
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(newsImageView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(95)
        }
        
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.contentView.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(newsImageView.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(20)
        }
    }
    
    private func configure(with favoriteNews: FavoriteNews){
        nameLabel.text = favoriteNews.title
        dateLabel.text = favoriteNews.date
        
        if let imageUrl = favoriteNews.imageUrl {
            NetworkManager.shared.fetchImage(from: imageUrl) { [weak self] result in
                switch result {
                case .success(let data):
                    self?.newsImageView.image = UIImage(data: data)
                case .failure(let error):
                    print(error)
                }
            }
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
