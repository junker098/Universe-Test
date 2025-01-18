//
//  CharactersTabCoordinator.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit

final class CharactersTabCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let networkServices: NetworkServicing
    private let data: CharactersModel
    private let favoritesService: FavoritesServicing
    
    init(networkServices: NetworkServicing, data: CharactersModel, favoritesService: FavoritesServicing) {
        self.networkServices = networkServices
        self.favoritesService = favoritesService
        self.data = data
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let viewModel = CharactersViewModel(initialData: data, favoritesService: favoritesService)
        let vc = CharactersListViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
