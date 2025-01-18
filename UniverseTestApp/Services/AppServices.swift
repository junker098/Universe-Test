//
//  AppServices.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import RxSwift
import UIKit

protocol NetworkServicing {
    func loadData() -> Single<CharactersModel>
}

final class NetworkService: NetworkServicing {
    func loadData() -> Single<CharactersModel> {
        return Single<CharactersModel>.create { single in
            DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
                let generatedItems = (1...20).map { DataItem(id: $0, title: "Item \($0)") }
                let model = CharactersModel(items: generatedItems)
                single(.success(model))
            }
            return Disposables.create()
        }
    }
}
