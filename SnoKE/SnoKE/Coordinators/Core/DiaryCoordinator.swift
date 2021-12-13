//
//  DiaryCoordinator.swift
//  SnoKE
//
//  Created by Ilya Buldin on 28.10.2021.
//

import UIKit


final class DiaryCoordinator: CoreCoordinator {
    
    override func start() {
        let diaryVC = EmotionsDiaryViewController()
        configure(self, with: diaryVC)
        navigationController.pushViewController(diaryVC, animated: false)
    }
}

