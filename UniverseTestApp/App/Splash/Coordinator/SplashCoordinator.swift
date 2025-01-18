//
//  SplashCoordinator.swift
//  UniverseTestApp
//
//  Created by Yuriy on 15.01.2025.
//

import RxSwift
import UIKit

final class SplashCoordinator: Coordinator {
    var navigationController: UINavigationController = UINavigationController()
    var childCoordinators: [Coordinator] = []
    
    private let disposeBag = DisposeBag()
    private let networkServices: NetworkServicing
    
    let splashCompleted = PublishSubject<CharactersModel>()
    
    init(networkServices: NetworkServicing) {
        self.networkServices = networkServices
    }
    
    func start() {
        let splashViewModel = SplashViewModel(networkServices: networkServices)
        let splashViewController = SplashViewController(viewModel: splashViewModel)
        
        splashViewModel.outputData
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.splashCompleted.onNext(data)
            })
            .disposed(by: disposeBag)
        
        navigationController.setViewControllers([splashViewController], animated: false)
    }
}
