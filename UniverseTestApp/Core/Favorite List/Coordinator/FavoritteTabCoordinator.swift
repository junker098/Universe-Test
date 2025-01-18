//
//  FavoritteTabCoordinator.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit

final class FavoriteTabCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let networkServices: NetworkServicing
    private let favoriteService: FavoritesServicing
    
    init(networkServices: NetworkServicing, favoriteService: FavoritesServicing) {
        self.networkServices = networkServices
        self.favoriteService = favoriteService
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let viewModel = FavoriteListViewModel(favoritesService: favoriteService)
        let vc = FavoriteListViewController(viewModel: viewModel)
        navigationController.viewControllers = [vc]
    }
}
