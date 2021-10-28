//
//  AppCorrdinator.swift
//  SnoKE
//
//  Created by Ilya Buldin on 28.10.2021.
//

import UIKit


final class AppCoordinator: MainCoordinatorProtocol {
    var childCoordinators: [ChildCoordinatorProtocol] = []
    
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController, childCoordinators: [ChildCoordinatorProtocol] = []) {
        self.tabBarController = tabBarController
        self.childCoordinators = childCoordinators
    }
    
    func start() {
        var navigationControllers: [UINavigationController] = []
        
        childCoordinators.forEach {
            navigationControllers.append($0.navigationController)
            $0.start()
        }
        
        tabBarController.viewControllers = navigationControllers
        guard let homeNavController = tabBarController.viewControllers?.first else {
            return
        }
        
        tabBarController.selectedViewController = homeNavController
    }
    
    
}
