//
//  SearchViewController.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class SearchViewController: UIViewController {
    
    var presenter: SearchPresenterProtocol?
    private let searchBar = UISearchBar()
    
    var model: [listDrugsModel]? {
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
        layout.itemSize = .init(width: 195,
                                height: 292)
        layout.sectionInset = .init(top: 5,
                                    left: 10,
                                    bottom: 5,
                                    right: 10)
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
        presenter?.viewDidLoad()
        navigationItem.leftBarButtonItem?.isHidden = true
        view.backgroundColor = UIColor(named: "backgroundColor")
        navigationController?.navigationBar.barTintColor = UIColor(named: "backgroundColor")
        navigationItem.titleView = navigationTitle
        setupeCollectionView()
        setupeSearchBar()
        setupeConstraint()
        setupeButton()
    }
//MARK: - setupeCollectionView
    private func setupeCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
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
//MARK: - extension SearchViewProtocol
extension SearchViewController: SearchViewProtocol {
    func dataSet(model: [listDrugsModel]) {
        self.model = model
    }
}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        presenter?.getSearchText(text: searchText)
        navigationTitle.text = searchText
    }
}
//MARK: - extension CollectionView
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//MARK: - numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        model?.count ?? 0
    }
//MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCell",
                                                      for: indexPath) as? CollectionViewCell
        let model = model?[indexPath.item]
        cell?.configures(model: model)
        return cell ?? UICollectionViewCell()
    }
//MARK: - didSelectItemAt
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let collectionView = self.collectionView.cellForItem(at: indexPath) else { return  }
        guard let model = model?[indexPath.item] else { return }
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
}
