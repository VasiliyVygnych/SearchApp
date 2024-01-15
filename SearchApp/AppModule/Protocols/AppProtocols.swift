//
//  AppProtocols.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

protocol AssemblerProtocol {
    func createSearchlView(coordinator: AppCoordinatorProtocol) -> UIViewController
    func createDetailView(model: listDrugsModel,
                          coordinator: AppCoordinatorProtocol) -> UIViewController
}

protocol AppCoordinatorProtocol {
    func initialView() 
    func showDetailView(model: listDrugsModel)
    
}

protocol NetworkProtocol {
    func search(completion: @escaping ([listDrugsModel]?) -> Void)
    func getDrugCard(id: Int,
                completion: @escaping (listDrugsModel?) -> Void)
}
