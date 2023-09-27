//
//  MainController.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import UIKit
import Alamofire
import Kingfisher

class MainController: UIViewController {
    
    var allSeries = [DataResults]()
    
    private var mainView: MainView {
        return view as! MainView
    }
    
    // MARK: - Life Cycle
    
    override func loadView() {
        super.loadView()
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Series"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.topViewController?.view.backgroundColor = UIColor(named: "Marvel")
    }
    
    private func setupHierarchy() {
        view.addSubview(mainView.tableView)
    }
}
