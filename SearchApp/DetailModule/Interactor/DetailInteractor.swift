//
//  DetailInteractor.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import Foundation

class DetailInteractor: DetailInteractorInputProtocol {
    
    var presenter: DetailInteractorOutputProtocol?
    var network: NetworkProtocol?
    var model: listDrugsModel?
    
    func getDetail() {
        guard let id = model?.id else { return }
        network?.getDrugCard(id: id,
                            completion: { [ weak self ] data in
            DispatchQueue.main.async {
                guard let model = data else { return }
                self?.presenter?.getData(model: model)
            }
        })
    }
}
