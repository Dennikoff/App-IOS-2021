//
//  SecondaryTrackerView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy


final class SecondaryTrackerView: UIView {
    
    // MARK: -Properties
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        
        return label
    }()
    
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.7176470588, blue: 0.7176470588, alpha: 1)
        layer.cornerRadius = 12
        
        addSubview(iconView)
        addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: -Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    func configure(with viewModel: SecondaryTrackerModel) {
        switch viewModel.type {
        case .savedMoney:
            self.textLabel.text = "+ " + String(viewModel.number) + " RUB"
        case .brokenCigarettes:
            self.textLabel.text = "- " + String(viewModel.number) + " шт"
        }
        self.iconView.image = UIImage(named: viewModel.type.icon)
    }
    
    private func setLayout() {
        iconView.easy.layout(
            Size(CGSize(width: 28, height: 20)),
            CenterY(),
            Left(14)
        )
        textLabel.easy.layout(
            CenterY(),
            CenterX()
        )
    }

}
