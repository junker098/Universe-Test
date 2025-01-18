//
//  AppCoordinator.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit
import RxSwift

final class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let networkServices: NetworkServicing
    private let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.networkServices = NetworkService()
    }
    
    func start() {
        let splashCoordinator = SplashCoordinator(networkServices: networkServices)
        
        splashCoordinator.splashCompleted
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                guard let self else { return }
                self.childCoordinators.removeAll()
                self.startMainFlow(with: data)
            })
            .disposed(by: disposeBag)
        
        childCoordinators.append(splashCoordinator)
        window.rootViewController = splashCoordinator.navigationController
        window.makeKeyAndVisible()
        splashCoordinator.start()
    }
    
    private func startMainFlow(with data: CharactersModel) {
        let tabBarCoordinator = TabBarCoordinator(networkServices: networkServices, data: data)
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        window.rootViewController = tabBarCoordinator.tabBarController
    }
}

