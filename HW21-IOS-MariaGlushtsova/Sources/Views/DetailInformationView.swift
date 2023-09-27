//
//  DetailInformationView.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import UIKit

class DetailInformationView: UIView {
    
    // MARK: - Outlets

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        return label
    }()
    
    lazy var image: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "DetailImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = false
        imageView.layer.masksToBounds = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 4.5, height: 4.5)
        imageView.layer.shadowRadius = 10
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = UIScreen.main.scale
        return imageView
    }()
    
   lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: "BackgroundOfDescription")
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        return label
    }()
    
    //MARK: -> Initial
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        backgroundColor = .systemGray3
    }
    
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(image)
        addSubview(descriptionLabel)
    }
    
    private func setupLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.width.equalTo(350)
        }
        
        image.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
        }
    }
}
