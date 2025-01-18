//
//  TabBarItemType.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit

enum TabBarItemType {
    
    case characters, favorites
    
    var title: String {
        switch self {
        case .characters:
            return "Characters"
        case .favorites:
            return "Favorites"
        }
    }
    
    var activeImage: UIImage? {
        switch self {
        case .characters:
            return UIImage(systemName: "list.bullet.rectangle")
        case .favorites:
            return UIImage(systemName: "star.fill")
        }
    }
    
    var inactiveImage: UIImage? {
        switch self {
        case .characters:
            return UIImage(systemName: "list.bullet")
        case .favorites:
            return UIImage(systemName: "star")
        }
    }
    
    func tabItem() -> UITabBarItem {
        UITabBarItem(title: title, image: inactiveImage, selectedImage: activeImage)
    }
}
