//
//  DetailProtocols.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

protocol DetailViewProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    func dataSet(model: listDrugsModel)
}

protocol DetailPresenterProtocol {
    var view: DetailViewProtocol? { get set }
    var interactor: DetailInteractorInputProtocol? { get set }
    var coordinator: AppCoordinatorProtocol? { get set }
    
    func viewDidLoad()
}

protocol DetailInteractorInputProtocol {
    var presenter: DetailInteractorOutputProtocol? { get set }
    var network: NetworkProtocol? { get set }
    var model: listDrugsModel? { get set }
    
    func getDetail()
}

protocol DetailInteractorOutputProtocol {
    func getData(model: listDrugsModel)
}
