//
//  CharactersListViewController.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CharactersListViewController: BaseViewController {
    //MARK: - 'Properties'
    typealias DataSection = CharactersModel
    private let viewModel: CharactersViewModel
    
    private let tableView = UITableView()
    private lazy var dataSource = RxTableViewSectionedReloadDataSource(configureCell: tableViewDatasourcesUI())
    private var addToFavoritesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        return button
    }()
    private let disposeBag = DisposeBag()
    
    //MARK: - 'Init'
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindInputs()
        bindOutputs()
    }
    
    //MARK: - 'Seup UI Interface'
    private func setupUI() {
        view.backgroundColor = .white
        tableView.registerCellAsClass(CharactersCellView.self)
        view.addSubview(tableView)
        view.addSubview(addToFavoritesButton)
        
        dataSource.titleForHeaderInSection = { _, _ in
            return "Items data"
        }
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalTo(addToFavoritesButton.snp.top).offset(-10)
        }
        addToFavoritesButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(44)
        }
    }
    
    private func tableViewDatasourcesUI() -> TableViewSectionedDataSource<CharactersModel>.ConfigureCell {
        { _, _, path, item in
            let cell = self.tableView.dequeueReusableCell(CharactersCellView.self, at: path)
            cell.configure(with: item)
            if self.viewModel.selectedItemsRelay.value.contains(item) {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            return cell
        }
    }
    
    //MARK: - 'Binding viewModel'
    private func bindInputs() {
        tableView.rx.modelSelected(DataItem.self)
            .bind(to: viewModel.input.selectItemTrigger)
            .disposed(by: disposeBag)
        
        addToFavoritesButton.rx.tap
            .bind(to: viewModel.input.addSelectedItemsTrigger)
            .disposed(by: disposeBag)
        
        viewModel.selectedItemsCount
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] count in
                guard let count = count.element, let self else { return }
                self.setupAddButtonTitle(count: count)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindOutputs() {
        viewModel.output.selectedItems
            .subscribe(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.output.items
            .map { [DataSection(items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setupAddButtonTitle(count: Int) {
        let countText = count > 0 ? " \(count)" : ""
        self.addToFavoritesButton.isEnabled = count > 0
        self.addToFavoritesButton.setTitle("Add\(countText) items to Favorites", for: .normal)
    }
}
