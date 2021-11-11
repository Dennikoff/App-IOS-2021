//
//  userWantToSmokeButton.swift
//  SnoKE
//
//  Created by Ilya Buldin on 30.10.2021.
//

import UIKit
import EasyPeasy

final class UserWantsToSmokeButton: UIButton {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.circle.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.text = "Я хочу покурить"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.2274509804, green: 0.568627451, blue: 0.6666666667, alpha: 1)
        layer.cornerRadius = 12
        
        addSubview(iconImageView)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        iconImageView.easy.layout(
            Size(42),
            Left(10),
            Top(10)
        )
        
        textLabel.easy.layout(
            Bottom(20),
            Right(20)
        )
    }
}

