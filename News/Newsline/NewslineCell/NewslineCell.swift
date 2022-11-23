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
    var viewModel: NewslineCellViewModelProtocol? { get }
}

class NewslineCell: UITableViewCell, CellModelRepresentable {
    var viewModel: NewslineCellViewModelProtocol? {
        didSet {
            updateView()
        }
    }
    
    static let identifier = "newslineCell"
    
    private var imageURL: URL? {
        didSet {
            imageView?.image = nil
//            updateImage()
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
                
        return activityIndicator
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.numberOfLines = 0
        return nameLabel
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 12, weight: .bold)
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
    
//    func configure(with news: News) {
//        nameLabel.text = news.title
//        dateLabel.text = news.date
//        
//        imageURL = URL(string: news.imageUrl ?? "")
//    }
    
    private func updateView() {
        guard let viewModel = viewModel as? NewslineCellViewModel else { return }
        
        nameLabel.text = viewModel.newsTitle
        dateLabel.text = viewModel.newsDate
        
        if let imageData = viewModel.imageData {
            newsImage.image = UIImage(data: imageData)
        }
        
    }
    
//    private func updateImage() {
//        guard let imageURL = imageURL else { return }
//        getImage(from: imageURL) { result in
//            switch result {
//            case .success(let image):
//                if imageURL == self.imageURL {
//                    self.newsImage.image = image
//                    self.activityIndicator.stopAnimating()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
    
//    private func getImage(from url: URL, completion : @escaping(Result<UIImage, Error>) -> Void) {
//        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
//            completion(.success(cacheImage))
//            return
//        }
//        
//        NetworkManager.shared.fetchImage(from: url) { result in
//            switch result {
//            case .success(let imageData):
//                guard let image = UIImage(data: imageData) else { return }
//                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
//                completion(.success(image))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
    
}
