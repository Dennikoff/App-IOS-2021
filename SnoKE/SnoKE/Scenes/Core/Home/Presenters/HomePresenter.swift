//
//  HomePresenter.swift
//  SnoKE
//
//  Created by Ilya Buldin on 29.10.2021.
//

import UIKit


protocol HomePresenterProtocol {
    func moreAchievementsButtonTapped()
    func userWantsToSmokeButtonTapped()
    func userSmokedButtonTapped()
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
    
    func userWantsToSmokeButtonTapped() {
        let vc = ViewController()
        coordinator?.modalPresentation(of: vc)
    }
    
    func userSmokedButtonTapped() {
        let vc = ViewController2()
        coordinator?.modalPresentation(of: vc)
    }
}
