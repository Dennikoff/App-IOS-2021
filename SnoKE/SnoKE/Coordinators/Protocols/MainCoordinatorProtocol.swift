//
//  MainCoordinatorProtocol.swift
//  SnoKE
//
//  Created by Ilya Buldin on 28.10.2021.
//

import UIKit


protocol MainCoordinatorProtocol: AnyObject {
    var childCoordinators: [ChildCoordinatorProtocol] { get set }
    var tabBarController: UITabBarController { get set }
    func start()
}
