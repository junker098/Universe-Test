//
//  TabBarController.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
    
    //COnfigure custom tabBar
    private func configureAppearance() {
        tabBar.tintColor = UIColor.blue
        tabBar.unselectedItemTintColor = UIColor.gray
    }
}
