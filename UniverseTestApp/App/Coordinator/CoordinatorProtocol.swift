//
//  CoordinatorProtocol.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
} 
