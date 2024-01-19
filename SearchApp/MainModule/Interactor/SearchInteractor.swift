//
//  SearchInteractor.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {
    
    var presenter: SearchInteractorOutputProtocol?
    var network: NetworkProtocol?
    var dataModel: listDrugsModel?
//MARK: - getData
    func getData(page: Int) {
        network?.fetchData(page: page,
                           completion: { [ weak self ] data in
            DispatchQueue.main.async {
                guard let model = data else { return }
                self?.presenter?.dataForTheView(model: model)
            }
        })
    }
}
