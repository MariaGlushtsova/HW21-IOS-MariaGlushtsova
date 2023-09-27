//
//  ComicsTableViewCell.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class ComicsTableViewCell: UITableViewCell {
      
    static let identifier = "ComicsTableViewCell"
    let networkManager = NetworkManager()

    // MARK: - Outlets

    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let comicsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let comicsDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.layer.masksToBounds = true
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Setup

    private func setupHierarchy() {
        contentView.addSubview(coverImage)
        contentView.addSubview(comicsTitleLabel)
        contentView.addSubview(comicsDescriptionLabel)
    }

    private func setupLayout() {

        coverImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(100)
        }

        comicsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImage)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(250)
        }

        comicsDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(comicsTitleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(250)
            make.left.equalTo(comicsTitleLabel)
        }
    }
    
    func configure(with results: DataResults) {
        comicsTitleLabel.text = results.title
        comicsDescriptionLabel.text = results.description ?? "Comics has no description"

        guard let imagePath = results.thumbnail?.path,
              let pathExtension = results.thumbnail?.extension,
              let urlImage = URL(string: imagePath + "." + pathExtension)
        else {
            coverImage.image = UIImage(named: "placeholderImage")
            return
        }
        DispatchQueue.global(qos: .background).async {
            self.networkManager.fetchImageForCell(urlImage: urlImage) { [weak self] data in
                self?.coverImage.kf.setImage(with: urlImage, placeholder: UIImage(named: "placeholderImage"))
            }
        }
    }
    
    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        coverImage.image = nil
        comicsTitleLabel.text = nil
        comicsDescriptionLabel.text = nil
    }
}
