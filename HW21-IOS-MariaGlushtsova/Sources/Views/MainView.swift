//
//  MainView.swift
//  HW21-IOS-MariaGlushtsova
//
//  Created by Admin on 27.09.23.
//

import UIKit

class MainView: UIView {
    
    // MARK: - Outlets
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    private func registerCelll() {
        tableView.register(SeriesTableViewCell.self,
                           forCellReuseIdentifier: SeriesTableViewCell.identifier)
    }
    
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
        registerCelll()
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Setup

    private func setupView() {
        backgroundColor = UIColor.white
    }

    private func setupHierarchy() {
        addSubview(tableView)
    }

    private func setupLayout() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}
