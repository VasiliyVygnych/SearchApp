//
//  AppCoordinator.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit

class AppCoordinator: AppCoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var assembler: AssemblerProtocol
    
    init(navigationController: UINavigationController?,
         assembler: AssemblerProtocol = Assembler()) {
        self.navigationController = navigationController
        self.assembler = assembler
    }
    
//MARK: - initialView
    func initialView() {
        if let navigationController = navigationController {
            let hotelView = assembler.createSearchlView(coordinator: self)
            navigationController.viewControllers = [hotelView]
        }
    }
//MARK: - showDetailView
    func showDetailView(model: listDrugsModel) {
        if let navigationController = navigationController {
            let detailViewController = assembler.createDetailView(model: model,
                                                                  coordinator: self)
            navigationController.pushViewController(detailViewController,
                                                    animated: true)
        }
    }
}
