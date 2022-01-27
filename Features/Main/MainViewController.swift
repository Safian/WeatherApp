//
//  MainViewController.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import UIKit
import Combine
import Swinject

class MainViewController: UIViewController {

    // MARK: - Disposables
    var disposables = Set<AnyCancellable>()

    // MARK: - Injected properties
    @Injected private var viewModel: MainViewModel
    @Injected private var navigationManager: NavigationManager

    //MARK: - UIOutlets

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.getCities()
    }

    // MARK: - Functions
    private func setup() {
        viewModel.$cellModels
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { viewData in
                self.tableView.reloadData()
            }).store(in: &disposables)
    }

    // MARK: - Navigation
    
    private func openDetails(with data: WeatherDetailsNavigationData) {
        navigationManager.navigateToWeatherDetail(with: data, navigationController: navigationController)
    }

}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.cellModels[indexPath.row].name
        content.secondaryText = viewModel.cellModels[indexPath.row].country
        cell.contentConfiguration = content
        return cell
    }
}

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cityData = viewModel.cellModels[indexPath.row]
        let navigationData = WeatherDetailsNavigationData(citiyName: cityData.name)
        openDetails(with: navigationData)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

