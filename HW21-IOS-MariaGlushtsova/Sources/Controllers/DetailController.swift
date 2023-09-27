//
//  DetailController.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import UIKit
import Kingfisher
import Alamofire

class DetailController: UIViewController {
    
    let networkManager = NetworkManager()
    
    var detailsOfComics: DataResults? {
        didSet {
            detailedSettingsView.titleLabel.text = detailsOfComics?.title
            detailedSettingsView.descriptionLabel.text = detailsOfComics?.description
            
            guard let imagePath = detailsOfComics?.thumbnail?.path,
                  let pathExtension = detailsOfComics?.thumbnail?.extension,
                  let urlImage = URL(string: imagePath + "." + pathExtension)
            else {
                detailedSettingsView.image.image = UIImage(named: "placeholderImage")
                return
            }
            networkManager.fetchImageForCell(urlImage: urlImage) { [weak self] data in
                self?.detailedSettingsView.image.kf.setImage(with: urlImage, placeholder: UIImage(named: "placeholderImage"))
            }
        }
    }

    // MARK: - Ui Elements
    let detailedSettingsView = DetailInformationView()

    // MARK: - Lifecycle
    override func loadView() {
        view = detailedSettingsView
    }
}
