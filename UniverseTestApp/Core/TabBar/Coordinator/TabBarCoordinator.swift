//
//  TabBarCoordinator.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit

final class TabBarCoordinator: NSObject, Coordinator {
    
    // MARK: - Coordinator protocol
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    // MARK: - Properties
    let tabBarController = TabBarController()
    private let networkServices: NetworkServicing
    private let data: CharactersModel
    
    init(networkServices: NetworkServicing, data: CharactersModel) {
        self.networkServices = networkServices
        self.data = data
        self.navigationController = UINavigationController()
    }
    
    // MARK: - Start
    
    func start() {
        let favoriteService = FavoritesService()
        let charactersTabCoordinator = CharactersTabCoordinator(networkServices: networkServices, data: data, favoritesService: favoriteService)
        let favoriteTabBarCoordinator = FavoriteTabCoordinator(networkServices: networkServices, favoriteService: favoriteService)
        
        childCoordinators.append(charactersTabCoordinator)
        childCoordinators.append(favoriteTabBarCoordinator)
        
        charactersTabCoordinator.start()
        favoriteTabBarCoordinator.start()
        
        let charactersNavigation = charactersTabCoordinator.navigationController
        let favoriteNavigation = favoriteTabBarCoordinator.navigationController
        
        charactersNavigation.tabBarItem = TabBarItemType.characters.tabItem()
        favoriteNavigation.tabBarItem = TabBarItemType.favorites.tabItem()
        
        tabBarController.viewControllers = [charactersNavigation, favoriteNavigation]
    }
}
