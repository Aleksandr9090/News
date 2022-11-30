//
//  NewslineCell.swift
//  News
//
//  Created by Aleksandr on 21.11.2022.
//

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
    
    private var imageUrl: URL? {
        didSet {
            newsImageView.image = nil
            activityIndicator.startAnimating()
            updateImage()
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private lazy var newsImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 35
        image.clipsToBounds = true
        return image
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
    
    private func updateView(){
        guard let viewModel = viewModel as? NewsCellViewModel else { return }
        
        nameLabel.text = viewModel.newsTitle
        dateLabel.text = viewModel.newsDate
        
        imageUrl = URL(string: viewModel.imageUrl)
        
    }
    
    private func updateImage() {
        guard let imageUrl = imageUrl else { return }
        getImage(from: imageUrl) { result in
            switch result {
            case .success(let image):
                if imageUrl == self.imageUrl {
                    self.newsImageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cacheImage))
            return
        }
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
