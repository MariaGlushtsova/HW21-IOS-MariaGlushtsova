//
//  SeriesTableViewCell.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class SeriesTableViewCell: UITableViewCell {
      
    static let identifier = "SeriesTableViewCell"

    // MARK: - Outlets

    let coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let seriesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    let seriesDescriptionLabel: UILabel = {
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
        contentView.addSubview(seriesTitleLabel)
        contentView.addSubview(seriesDescriptionLabel)
    }

    private func setupLayout() {

        coverImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(100)
        }

        seriesTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImage)
            make.left.equalToSuperview().offset(130)
            make.width.equalTo(250)
        }

        seriesDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(seriesTitleLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(250)
            make.left.equalTo(seriesTitleLabel)
        }
    }
    
    // MARK: - Reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        coverImage.image = nil
        seriesTitleLabel.text = nil
        seriesDescriptionLabel.text = nil
    }
}
