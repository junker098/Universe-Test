//
//  FavoritesServices.swift
//  UniverseTestApp
//
//  Created by Yuriy on 18.01.2025.
//

import RxSwift
import RxCocoa

protocol FavoritesServicing {

    var favorites: BehaviorRelay<[DataItem]> { get }
    
    func addToFavorites(items: [DataItem])
    func removeFromFavorites(item: DataItem)
    func clearFavorites()
}

final class FavoritesService: FavoritesServicing {
    
    let favorites = BehaviorRelay<[DataItem]>(value: [])
    
    func addToFavorites(items: [DataItem]) {
        var currentFavorites = favorites.value
        let newItems = items.filter { !currentFavorites.contains($0) }
        if !newItems.isEmpty {
            currentFavorites.append(contentsOf: newItems)
            favorites.accept(currentFavorites)
        }
    }
    
    func removeFromFavorites(item: DataItem) {
        var currentFavorites = favorites.value
        if let index = currentFavorites.firstIndex(of: item) {
            currentFavorites.remove(at: index)
            favorites.accept(currentFavorites)
        }
    }
    
    func clearFavorites() {
        favorites.accept([])
    }
}
