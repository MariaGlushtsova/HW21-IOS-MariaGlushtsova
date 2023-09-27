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
    
    var detailsOfSeries: DataResults? {
        didSet {
            detailedSettingsView.titleLabel.text = detailsOfSeries?.title
            detailedSettingsView.descriptionLabel.text = detailsOfSeries?.description
            
            guard let imagePath = detailsOfSeries?.thumbnail?.path,
                  let pathExtension = detailsOfSeries?.thumbnail?.extension,
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
