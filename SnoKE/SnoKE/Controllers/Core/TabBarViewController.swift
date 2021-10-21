//
//  TabBarViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: -Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let achievementsVC = AchievementsViewController()
        let profileVC = ProfileViewController()
        
        homeVC.title = "SnoKE"
        achievementsVC.title = "Дневник"
        profileVC.title = "Профиль"
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        achievementsVC.navigationItem.largeTitleDisplayMode = .never
        profileVC.navigationItem.largeTitleDisplayMode = .never

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .secondarySystemBackground
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.navigationBar.compactAppearance = appearance
        
        let achievementsNav = UINavigationController(rootViewController: achievementsVC)
        achievementsNav.navigationBar.compactAppearance = appearance
        
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.navigationBar.compactAppearance = appearance
        
        homeNav.navigationBar.tintColor = .label
        achievementsNav.navigationBar.tintColor = .label
        profileNav.navigationBar.tintColor = .label
        
        homeNav.tabBarItem = UITabBarItem(title: "Главная",
                                       image: UIImage(systemName: "house.fill"),
                                       tag: 1
        )
        achievementsNav.tabBarItem = UITabBarItem(title: "Дневник",
                                       image: UIImage(systemName: "book.closed.fill"),
                                       tag: 2
        )
        profileNav.tabBarItem = UITabBarItem(title: "Профиль",
                                       image: UIImage(systemName: "figure.wave"),
                                       tag: 3
        )
        
        tabBar.tintColor = .label
        
        
        homeNav.navigationBar.prefersLargeTitles = true
        achievementsNav.navigationBar.prefersLargeTitles = true
        profileNav.navigationBar.prefersLargeTitles = true
        
        setViewControllers([homeNav, achievementsNav, profileNav], animated: false)
    }
}
