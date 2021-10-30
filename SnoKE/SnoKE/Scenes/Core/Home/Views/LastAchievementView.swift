//
//  LastAchievementView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 30.10.2021.
//

import UIKit
import EasyPeasy

final class LastAchievementView: UIView {
    
    private lazy var achievementIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "star.fill")
        icon.tintColor = .white
        
        icon.contentMode = .scaleAspectFill
        return icon
    }()
    
    private lazy var achievementTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "Вы сэкономили"
        label.textColor = .white
        return label
    }()
    
    private lazy var achievementText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.text = "25000 RUB"
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.4, alpha: 1)
        layer.cornerRadius = 12

        let allSubviews = [
            achievementIcon,
            achievementTitle,
            achievementText
        ]
        allSubviews.forEach {
            addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        achievementIcon.easy.layout(
            CenterY(),
            Width(height / 2),
            Left(10)
        )
        
        achievementTitle.easy.layout(
            CenterY(-height/8),
            Left(12).to(achievementIcon)
        )

        achievementText.easy.layout(
            CenterY(height/8),
            Left(12).to(achievementIcon)
        )
    }
}
