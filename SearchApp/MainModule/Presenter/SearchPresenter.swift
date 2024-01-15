//
//  SearchPresenter.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

class SearchPresenter: SearchPresenterProtocol {
    
    var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var coordinator: AppCoordinatorProtocol?
    
//MARK: - goDetailView
    func goDetailView(model: listDrugsModel) {
        coordinator?.showDetailView(model: model)
    }
//MARK: - getSearchText
    func getSearchText(text: String) {
        print("text = \(text)")
    }
//MARK: - viewDidLoad
    func viewDidLoad() {
        interactor?.getData()
    }
}
extension SearchPresenter: SearchInteractorOutputProtocol {
    func dataForTheView(model: [listDrugsModel]) {
        view?.dataSet(model: model)
    }
}
