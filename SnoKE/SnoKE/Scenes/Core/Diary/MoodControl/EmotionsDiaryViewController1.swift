//
//  AchievementsViewController.swift
//  SnoKE
//
//  Created by Kristina Shlyapkina on 18.11.2021.
//

import SwiftUI
import EasyPeasy

class EmotionsDiaryViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let emotionView = EmotionDiaryView()
        view.addSubview(emotionView)
        emotionView.easy.layout(
            Top(0),
            Right(0),
            Left(0),
            Bottom(0)
        )
        view.backgroundColor = .white
    }
    
    
    
}
