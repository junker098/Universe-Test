//
//  Extensions.swift
//  UniverseTestApp
//
//  Created by Yuriy on 17.01.2025.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, at indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? T else {
            fatalError("Could not dequeueReusableCell with identefier: \(String(describing: type))")
        }
        return cell
    }
    
    func registerCellAsClass<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: type))
    }
}
