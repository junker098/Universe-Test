//
//  CharactersViewModel.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit
import RxSwift
import RxCocoa

final class CharactersViewModel: RootViewModelInterface {    
    //MARK: - Properties
    let input: Input
    let output: Output
    
    private let initialData: CharactersModel
    private let favoritesService: FavoritesServicing
    private let itemsRelay = BehaviorRelay<[DataItem]>(value: [])
    private let addSelectedItemsSubject = PublishSubject<Void>()
    private let selectItemSubject = PublishSubject<DataItem>()
    private let disposeBag = DisposeBag()
    
    //public property
    let selectedItemsRelay = BehaviorRelay<[DataItem]>(value: [])
    var selectedItemsCount: Observable<Int> {
        return selectedItemsRelay.asObservable().map { $0.count }
    }
    
    //MARK: - 'Init'
    init(initialData: CharactersModel, favoritesService: FavoritesServicing) {
        self.initialData = initialData
        self.favoritesService = favoritesService
        itemsRelay.accept(initialData.items)
        
        self.input = Input(
            addSelectedItemsTrigger: addSelectedItemsSubject.asObserver(),
            selectItemTrigger: selectItemSubject.asObserver()
        )
        
        self.output = Output(
            items: itemsRelay.asObservable(),
            selectedItems: selectedItemsRelay.asObservable()
        )
        
        bindInputs()
    }
    
    //MARK: - 'Binding'
    private func bindInputs() {
        selectItemSubject
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.select(item: item)
            })
            .disposed(by: disposeBag)
        
        addSelectedItemsSubject
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.addToFavorites()
            })
            .disposed(by: disposeBag)
    }
    
    //MARK: - 'Methods'
    private func select(item: DataItem) {
        var current = self.selectedItemsRelay.value
        if current.contains(item), let index = current.firstIndex(of: item) {
            current.remove(at: index)
        } else {
            current.append(item)
        }
        self.selectedItemsRelay.accept(current)
    }
    
    private func addToFavorites() {
        let selectedItems = self.selectedItemsRelay.value
        self.favoritesService.addToFavorites(items: selectedItems)
        self.selectedItemsRelay.accept([])
    }
}

//MARK: - 'Input & Output'
extension CharactersViewModel {
    struct Input {
        let addSelectedItemsTrigger: AnyObserver<Void>
        let selectItemTrigger: AnyObserver<DataItem>
    }
    
    struct Output {
        let items: Observable<[DataItem]>
        let selectedItems: Observable<[DataItem]>
    }
}
