//
//  FavoriteListViewModel.swift
//  UniverseTestApp
//
//  Created by Yuriy on 18.01.2025.
//

import RxSwift
import RxCocoa

final class FavoriteListViewModel {
    //MARK: - 'Property'
    let output: Output
    let input: Input
    
    private let favoritesService: FavoritesServicing
    private let disposeBag = DisposeBag()
    private let removeFavoriteSubject = PublishSubject<DataItem>()
    private let removeAllFavoritesSubject = PublishSubject<Void>()
    
    //MARK: - 'Init'
    init(favoritesService: FavoritesServicing) {
        self.favoritesService = favoritesService
        
        self.output = Output(
            favorites: favoritesService.favorites.asObservable()
        )
        self.input = Input(
            removeFavoriteTrigger: removeFavoriteSubject.asObserver(),
            removeAllFavoritesTrigger: removeAllFavoritesSubject.asObserver()
        )
        bindInputs()
    }
    
    //MARK: - 'Binding'
    private func bindInputs() {
        removeFavoriteSubject
            .subscribe(onNext: { [weak self] item in
                guard let self else { return }
                self.removeFromFavorites(item: item)
            })
            .disposed(by: disposeBag)
        
        removeAllFavoritesSubject
            .subscribe(onNext: { [weak self] in
                guard let self else { return }
                self.removeAllFavorites()
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - 'Methods'
    private func removeFromFavorites(item: DataItem) {
        favoritesService.removeFromFavorites(item: item)
    }
    
    private func removeAllFavorites() {
        favoritesService.clearFavorites()
    }
}

//MARK: - 'Input & Output'
extension FavoriteListViewModel {
    struct Output {
        let favorites: Observable<[DataItem]>
    }
    
    struct Input {
        let removeFavoriteTrigger: AnyObserver<DataItem>
        let removeAllFavoritesTrigger: AnyObserver<Void>
    }
}
