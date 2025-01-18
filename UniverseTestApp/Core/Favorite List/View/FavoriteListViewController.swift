//
//  FavoriteListViewController.swift
//  UniverseTestApp
//
//  Created by Yuriy on 14.01.2025.
//

import UIKit
import RxSwift
import RxDataSources

final class FavoriteListViewController: BaseViewController {
    //MARK: - 'Property'
    typealias DataSection = SectionModel<String, DataItem>
    private let viewModel: FavoriteListViewModel

    private let tableView = UITableView()
    private lazy var dataSource = RxTableViewSectionedReloadDataSource(configureCell: tableViewDatasourcesUI())
    private var removeAllButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "Delete All", style: .plain, target: nil, action: nil)
        return barButton
    }()
    private let disposeBag = DisposeBag()
    
    //MARK: - 'Init'
    init(viewModel: FavoriteListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        bindViewModel()
    }
    //MARK: - 'Setup Interfase'
    private func setupUI() {
        navigationItem.rightBarButtonItem = removeAllButton
        view.backgroundColor = .white
        tableView.registerCellAsClass(CharactersCellView.self)
        view.addSubview(tableView)
        
        dataSource.titleForHeaderInSection = { _, _ in
            return "Favorites data"
        }
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func tableViewDatasourcesUI() -> TableViewSectionedDataSource<DataSection>.ConfigureCell {
        { _, _, path, item in
            let cell = self.tableView.dequeueReusableCell(CharactersCellView.self, at: path)
            cell.configure(with: item)
            return cell
        }
    }
    //MARK: - 'Bind ViewModel'
    private func bindViewModel() {
        viewModel.output.favorites
            .map { [DataSection(model: "Favorites", items: $0)] }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self,
                      let item = try? self.dataSource.model(at: indexPath) as? DataItem
                else {
                    return
                }
                self.viewModel.input.removeFavoriteTrigger.onNext(item)
            })
            .disposed(by: disposeBag)
        
        removeAllButton.rx.tap
            .bind(to: viewModel.input.removeAllFavoritesTrigger)
            .disposed(by: disposeBag)
    }
}
