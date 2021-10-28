//
//  HomePresenter.swift
//  SnoKE
//
//  Created by Ilya Buldin on 29.10.2021.
//

import UIKit


protocol HomePresenterProtocol {
    func moreAchievementsButtonTapped()
}


final class HomePresenter {
    
    private weak var coordinator: HomeCoordinator?
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
}

extension HomePresenter: HomePresenterProtocol {
    func moreAchievementsButtonTapped() {
        let achievementsVC = AchievementsViewController()
        achievementsVC.title = "Достижения"
        coordinator?.coordinate(to: achievementsVC)
    }
}
