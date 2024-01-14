//
//  Assembler.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

class Assembler: AssemblerProtocol {
    
//MARK: - createSearchlView
    func createSearchlView(coordinator: AppCoordinatorProtocol) -> UIViewController {
        let viewController = SearchViewController()
        var presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
        var interactor: SearchInteractorInputProtocol = SearchInteractor()
        let network: NetworkProtocol = Network()
        let coordinator = coordinator
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.presenter = presenter
        interactor.network = network
        return viewController
    }
//MARK: - createDetailView
    func createDetailView(model: listDrugsModel,
                          coordinator: AppCoordinatorProtocol) -> UIViewController {
        let viewController = DetailViewController()
        var presenter: DetailPresenterProtocol & DetailInteractorOutputProtocol = DetailPresenter()
        var interactor: DetailInteractorInputProtocol = DetailInteractor()
        let network: NetworkProtocol = Network()
        let coordinator = coordinator
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.coordinator = coordinator
        interactor.presenter = presenter
        interactor.model = model
        interactor.network = network
        return viewController
    }  
}
