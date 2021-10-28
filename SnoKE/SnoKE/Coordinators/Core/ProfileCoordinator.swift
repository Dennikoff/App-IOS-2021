//
//  ProfileCoordinator.swift
//  SnoKE
//
//  Created by Ilya Buldin on 28.10.2021.
//

import UIKit


final class ProfileCoordinator: CoreCoordinator {
     
    override func start() {
        let profileVC = ProfileViewController()
        configure(self, with: profileVC)
        navigationController.pushViewController(profileVC, animated: false)
    }
}
