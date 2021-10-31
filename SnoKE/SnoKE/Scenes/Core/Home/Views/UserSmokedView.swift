//
//  UserSmokedView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 30.10.2021.
//

import UIKit
import EasyPeasy

final class UserSmokedButton: UIButton {
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.circle.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .white
        label.text = "Я покурил"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.5058823529, blue: 0.5058823529, alpha: 1)
        layer.cornerRadius = 12
        
        addSubview(iconImageView)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout() {
        iconImageView.easy.layout(
            Size(42),
            CenterX(),
            Top(10)
        )
        
        textLabel.easy.layout(
            Bottom(20),
            CenterX()
        )
    }
    
}
