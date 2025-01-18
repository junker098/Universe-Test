//
//  SplashViewModel.swift
//  UniverseTestApp
//
//  Created by Yuriy on 15.01.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class SplashViewModel {
    
    //MARK: - 'Property'
    private let networkServices: NetworkServicing
    private let dataSubject = PublishSubject<CharactersModel>()
    var outputData: Observable<CharactersModel> {
        return dataSubject.asObservable()
    }
    private let disposeBag = DisposeBag()
    
    //MARK: - 'Init'
    init(networkServices: NetworkServicing) {
        self.networkServices = networkServices
        self.loadData()
    }
    
    func loadData() {
        networkServices.loadData()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .success(let model):
                    self.dataSubject.onNext(model)
                case .failure(let error):
                    print(error.localizedDescription)
                    //catch error
                }
            }
            .disposed(by: disposeBag)
    }
}

