//
//  AchievementTableViewCell.swift
//  SnoKE
//
//  Created by Ilya Buldin on 13.12.2021.
//

import UIKit
import EasyPeasy

enum AchievementType {
    case budget
    case ecology
    case health
    case scope
    
    var category: String {
        switch self {
        case.budget:
            return "Бюджет"
        case.ecology:
            return "Экология"
        case .health:
            return "Здоровье"
        case .scope:
            return "Масштабы"
        }
    }
    
    var imageSystemName: String {
        switch self {
        case .budget:
            return "rublesign.square.fill"
        case .ecology:
            return "drop.fill"
        case .health:
            return "lessthan.square.fill"
        case .scope:
            return "globe"
        }
    }
}

struct AchievementModel {
    let date: String
    let chapter: String
    let description: String
    let achievementText: String
    let type: AchievementType
}

class AchievementTableViewCell: UITableViewCell {
    
    static let identifier = "AchievementTableViewCell"
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 245/255, alpha: 1)
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var category: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var chapter: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var achievementDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var achievementText: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    private lazy var achievementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        return imageView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isLast: Bool = false, model: AchievementModel) {
        if isLast {
            changeColorsForLastAchievement(type: model.type)
        }
        dateLabel.text = model.date
        category.text = model.type.category
        chapter.text = model.chapter
        achievementDescription.text = model.description
        achievementText.text = model.achievementText
        achievementImageView.image = UIImage(systemName: model.type.imageSystemName)
    }
    
    private func changeColorsForLastAchievement(type: AchievementType) {
        switch type {
        case .budget:
            containerView.backgroundColor = UIColor(red: 237/255, green: 206/255, blue: 99/255, alpha: 1)
        case .ecology:
            containerView.backgroundColor = UIColor(red: 166/255, green: 198/255, blue: 70/255, alpha: 1)
        case .health:
            containerView.backgroundColor = UIColor(red: 249/255, green: 154/255, blue: 154/255, alpha: 1)
        case .scope:
            containerView.backgroundColor = UIColor(red: 1/255, green: 166/255, blue: 241/255, alpha: 1)
        }
        let textViews = [category, chapter, achievementDescription, achievementText]
        textViews.forEach {
            $0.textColor = .white
        }
        achievementImageView.tintColor = .white
    }
    
    private func setupViews() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(containerView)
        let views = [category, chapter, achievementDescription, achievementImageView, achievementText]
        views.forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupLayout() {
        dateLabel.easy.layout(
            Top(20),
            Left(17)
        )
        
        containerView.easy.layout(
            Top(4),
            Bottom(4),
            Width(250),
            Right(17)
        )
        
        category.easy.layout(
            Top(16),
            Left(16)
        )
        
        chapter.easy.layout(
            Top().to(category),
            Left(16)
        )
        
        achievementDescription.easy.layout(
            Top(5).to(chapter),
            Width(200),
            Left(16)
        )
        
        achievementImageView.easy.layout(
            Left(16),
            Bottom(10),
            Height(22)
        )
        
        achievementText.easy.layout(
            Left(10).to(achievementImageView),
            CenterY().to(achievementImageView)
        )
    }
}
