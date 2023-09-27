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
    
    let networkManager = NetworkManager()
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
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        fetchSeries()
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
    
    private func fetchSeries() {
        networkManager.fetchSeries(url: networkManager.urlCharacterSeries) { [weak self] result in
            switch result {
            case .success(let result):
                self?.allSeries = result.data.results
                self?.mainView.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MainController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSeries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesTableViewCell", for: indexPath) as? SeriesTableViewCell
        
        var model = allSeries[indexPath.row]
        
        cell?.configure(with: model)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MainController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
            tableView.deselectRow(at: indexPath, animated: true)
        }
}
