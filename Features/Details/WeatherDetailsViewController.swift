//
//  WeatherDetailsViewController.swift
//  weatherApp
//
//  Created by Safian Szabolcs on 2022. 01. 26..
//

import UIKit
import Combine

class WeatherDetailsViewController: UIViewController {

    // MARK: - Injected properties
    @Injected private var viewModel: WeatherDetailsViewModel

    // MARK: - Disposables
    var disposableImage: AnyCancellable?

    // MARK: - Outlets

    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var tempMaxLabel: UILabel!
    @IBOutlet var tempMinLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageView: UIImageView!


    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel.getData()
    }

    // MARK: - Private Functions

    private func setup() {
        setupUI()
        setupObservables()
    }

    private func setupUI() {
        title = viewModel.navigationData?.citiyName
    }

    private func setupObservables() {
        viewModel.$detailsModels
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] data in
                guard let data = data else { return }
                self?.bind(with: data)
            }).store(in: &viewModel.disposables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] error in
                guard let error = error else { return }
                self?.showError(with: error)
            }).store(in: &viewModel.disposables)
    }

    private func bind(with data: DetailsViewModel) {
        tempLabel.text = data.temperature
        tempMaxLabel.text = data.temperatureMax
        tempMinLabel.text = data.temperatureMin
        descriptionLabel.text = data.description
        guard let url = URL(string: data.iconUrl) else { return }
        loadImage(form: url)
    }

    private func loadImage(form url: URL) {
        disposableImage = URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)! }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.self.imageView.image , on: self)
    }

    private func showError(with error: String) {
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)

    }


    // MARK: - Instantiate Self From Stroyboard

    public static func createViewController(_ data: WeatherDetailsNavigationData) -> WeatherDetailsViewController? {
        let storyboard = UIStoryboard(name: "WeatherDetails", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? WeatherDetailsViewController
        viewController?.viewModel.navigationData = data
        return viewController
    }

}
