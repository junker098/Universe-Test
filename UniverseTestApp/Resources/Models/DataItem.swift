//
//  DataItem.swift
//  UniverseTestApp
//
//  Created by Yuriy on 15.01.2025.
//

import Foundation
import RxDataSources

struct DataItem: Equatable, Hashable {
    let id: Int
    let title: String
}

struct CharactersModel: SectionModelType {
    
    var items: [DataItem]
    
    init(original: CharactersModel, items: [DataItem]) {
        self = original
        self.items = items
    }
    
    init(items: [DataItem]) {
        self.items = items
    }
}
