//
//  CoreCoordinator.swift
//  SnoKE
//
//  Created by Ilya Buldin on 29.10.2021.
//

import UIKit


class CoreCoordinator: ChildCoordinatorProtocol, CoreCoordinatorsConfigurationProtocol {
    var navigationController: UINavigationController
    
    let imageName: String
    let title: String
    let tabBarItemTag: Int
    
    init(navigationController: UINavigationController, imageName: String, title: String, tabBarItemTag: Int) {
        self.navigationController = navigationController
        self.imageName = imageName
        self.title = title
        self.tabBarItemTag = tabBarItemTag
    }
    
    func start() {
        fatalError("[CoreCoordinator аssertion]: Must be overriden")
    }
}
