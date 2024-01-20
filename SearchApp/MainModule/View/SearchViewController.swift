//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    private let searchBar = UISearchBar(frame: .zero)
    private var dataSource: UICollectionViewDiffableDataSource<Sections,
                                                                listDrugsModel>?
    
    private var model: [listDrugsModel]? {
        didSet {
            collectionView.reloadData()
        }
    }
    private var searchModel = [listDrugsModel]() {
        didSet {
            collectionView.reloadData()
        }
    }
//MARK: - navigationTitle
    private var navigationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17,
                                 weight: .bold)
        label.textAlignment = .center
        label.textColor = .white
        label.font = .sFProDisplay(ofSize: 17,
                                   weight: .bold)
        return label
    }()
//MARK: - collectionView & FlowLayout
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 164,
                                height: 296)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = .init(top: 10,
                                    left: 16,
                                    bottom: 10,
                                    right: 16)
        return layout
    }()
    lazy var collectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: .zero,
                                             collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentMode = .scaleAspectFit
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
   }()
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getDataView(page: 10)
        navigationItem.leftBarButtonItem?.isHidden = true
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        navigationItem.titleView = navigationTitle
        setupeCollectionView()
        setupeSearchBar()
        setupeConstraint()
        setupeButton()
        configureDataSourse()
    }
//MARK: - setupeCollectionView
    private func setupeCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self,
                                forCellWithReuseIdentifier: "viewCell")
    }
//MARK: - setupeSearch
    private func setupeSearchBar() {
        searchBar.searchTextField.backgroundColor = .white
        searchBar.delegate = self
    }
//MARK: - setupeButton
    private func setupeButton() {
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(back))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
        let searshButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(showSearch))
        searshButton.tintColor = .white
        navigationItem.rightBarButtonItem = searshButton
    }
//MARK: - @objc func
    @objc func showSearch() {
        navigationItem.leftBarButtonItem?.isHidden = false
        navigationItem.rightBarButtonItem?.isHidden = true
        navigationItem.titleView = searchBar
    }
    @objc func back() {
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = false
        navigationItem.titleView = navigationTitle
    }
//MARK: - setupeConstraint
    private func setupeConstraint() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: - DiffableDataSource
extension SearchViewController {
    func configureDataSourse() {
        let cellRegistration = UICollectionView.CellRegistration
        <CollectionViewCell,
         listDrugsModel> { (cell, indexPath, model) in
            cell.configures(model: model)
        }
        dataSource = UICollectionViewDiffableDataSource<Sections, listDrugsModel> (collectionView: collectionView) {
            (collectionView: UICollectionView,
             indexPath: IndexPath,
             identifier: listDrugsModel) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
//MARK: - performSearch
    func performSearch(searchText: String?) {
        guard let model = model,
        let text = searchText else { return }
        searchModel = model.filter({ (models: listDrugsModel) -> Bool in
            return models.name.lowercased().contains(text.lowercased())
        })
        var snapShot = NSDiffableDataSourceSnapshot<Sections,
                                                    listDrugsModel>()
            snapShot.appendSections([.search])
        if searchText == "" {
            snapShot.appendItems(model)
        } else {
            snapShot.appendItems(searchModel)
        }
        dataSource?.apply(snapShot,
                         animatingDifferences: true)
    }
}
//MARK: - extension SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func dataSet(model: [listDrugsModel]) {
        self.model = model
        var snapShot = NSDiffableDataSourceSnapshot<Sections,
                                                    listDrugsModel>()
        snapShot.appendSections([.main])
        snapShot.appendItems(model)
        dataSource?.apply(snapShot,
                          animatingDifferences: true)
    }
}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        navigationTitle.text = searchText
        performSearch(searchText: searchText)
    }
}
//MARK: - extension CollectionView
extension SearchViewController: UICollectionViewDelegate {
//MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let collectionView = self.collectionView.cellForItem(at: indexPath),
              let model = dataSource?.itemIdentifier(for: indexPath) else { return }
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            collectionView.transform = CGAffineTransform(scaleX: 0.75,
                                                         y: 0.75)
            collectionView.backgroundColor = .lightGray
        }, completion: { finished in
            self.presenter?.goDetailView(model: model)
        })
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            collectionView.transform = CGAffineTransform(scaleX: 1,
                                                         y: 1)
            collectionView.backgroundColor = .white
        }, completion: nil)
    }
//MARK: - willDisplay
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let model = self.model?[indexPath.item],
              let page = dataSource?.indexPath(for: model),
              var pageCount = self.model?.count else { return }
        let total = 20
        if page.last == (self.model?.count ?? 0) - 3 && self.model?.count ?? 0 < total {
            pageCount += 5
            presenter?.getDataView(page: pageCount)
        }
    }
}
