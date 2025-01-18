//
//  CharactersCellView.swift
//  UniverseTestApp
//
//  Created by Yuriy on 18.01.2025.
//

import UIKit
import SnapKit

final class CharactersCellView: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.leading.equalToSuperview().offset(16)
            maker.bottom.trailing.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with item: DataItem) {
        titleLabel.text = item.title
    }
}
