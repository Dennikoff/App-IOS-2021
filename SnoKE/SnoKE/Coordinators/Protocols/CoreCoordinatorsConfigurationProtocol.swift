//
//  CoreCoordinatorsConfigurationProtocol.swift
//  SnoKE
//
//  Created by Ilya Buldin on 28.10.2021.
//

import UIKit


protocol CoreCoordinatorsConfigurationProtocol {
    var imageName: String { get }
    var title: String { get }
    var tabBarItemTag: Int { get }
    
    func configure(_ coordinator: ChildCoordinatorProtocol, with vc: UIViewController)
}

extension CoreCoordinatorsConfigurationProtocol {
    func configure(_ coordinator: ChildCoordinatorProtocol, with vc: UIViewController) {
        vc.title = title
        coordinator.navigationController.tabBarItem = UITabBarItem(title: title,
                                                                   image: UIImage(systemName: imageName),
                                                                   tag: tabBarItemTag)
    }
}
