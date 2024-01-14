//
//  MainProtocols.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

protocol SearchViewProtocol {
    var presenter: SearchPresenterProtocol? { get set }
    func dataSet(model: [listDrugsModel])
}

protocol SearchPresenterProtocol {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var coordinator: AppCoordinatorProtocol? { get set }

    func goDetailView(model: listDrugsModel)
    func getSearchText(text: String)
}

protocol SearchInteractorInputProtocol {
    var presenter: SearchInteractorOutputProtocol? { get set }
    var network: NetworkProtocol? { get set }
    
    func setSearchText(text: String)
}

protocol SearchInteractorOutputProtocol {
    func dataForTheView(model: [listDrugsModel])
}
