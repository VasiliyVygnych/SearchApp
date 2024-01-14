//
//  DetailPresenter.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

class DetailPresenter: DetailPresenterProtocol {
    
    var view: DetailViewProtocol?
    var interactor: DetailInteractorInputProtocol?
    var coordinator: AppCoordinatorProtocol?
    
    func viewDidLoad() {
        interactor?.getDetail()
    }
}
extension DetailPresenter: DetailInteractorOutputProtocol {
    func getData(model: listDrugsModel) {
        view?.dataSet(model: model)
    }
}
