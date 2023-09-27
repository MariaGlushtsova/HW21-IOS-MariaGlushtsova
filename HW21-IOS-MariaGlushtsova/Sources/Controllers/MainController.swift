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
    var allComics = [DataResults]()
    var searcModel = [DataResults]()
    var filteredData = [DataResults]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
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
        
        filteredData = allComics
        
        setupView()
        setupHierarchy()
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        fetchSeries()
    }
    
    // MARK: - Private Functions
    
    private func setupView() {
        view.backgroundColor = .white
        title = "Jessica Jones Comics"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.topViewController?.view.backgroundColor = UIColor(named: "Marvel")
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск по комиксам"
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupHierarchy() {
        view.addSubview(mainView.tableView)
    }
    
    private func fetchSeries() {
        networkManager.fetchSeries(url: networkManager.urlCharacterComics) { [weak self] result in
            switch result {
            case .success(let result):
                self?.allComics = result.data.results
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
        if isFiltering {
            return filteredData.count
        }
        return allComics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell", for: indexPath) as? ComicsTableViewCell
        
        var model: DataResults
        
        if isFiltering {
            model = filteredData[indexPath.row]
        } else {
            model = allComics[indexPath.row]
        }
                
        cell?.configure(with: model)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension MainController: UITableViewDelegate {

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let viewController = DetailController()
            
            var model: DataResults
            
            if isFiltering {
                model = filteredData[indexPath.row]
            } else {
                model = allComics[indexPath.row]
            }
            
            tableView.deselectRow(at: indexPath, animated: true)
            viewController.detailsOfComics = model
            present(viewController, animated: true)
        }
}

// MARK: - UISearchBarDelegate

extension MainController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? String())
    }
    
    func filterContentForSearchText(_ searchText: String) {
        searchSeries()
        filteredData = searcModel.filter({ (dataSeries: DataResults) -> Bool in
            return dataSeries.title.lowercased().contains(searchText.lowercased())
        })
        mainView.tableView.reloadData()
    }
    
    func searchSeries() {
        networkManager.fetchSeries(url: networkManager.urlCharacterComics) { [weak self] result in
            switch result {
            case .success(let result):
                self?.searcModel.append(contentsOf: result.data.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
