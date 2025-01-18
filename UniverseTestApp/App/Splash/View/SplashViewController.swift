//
//  SplashViewController.swift
//  UniverseTestApp
//
//  Created by Yuriy on 15.01.2025.
//

import UIKit
import SnapKit

final class SplashViewController: BaseViewController {
    
    //MARK: - 'Property'
    private let viewModel: SplashViewModel
    
    private var splashLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom splash \n(with image or logo animation)"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    //MARK: - 'Init'
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.loadData()
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    //MARK: - 'Setup UI Interface'
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(splashLabel)
    }
    
    private func setupConstraints() {
        splashLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
