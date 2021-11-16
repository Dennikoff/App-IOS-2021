//
//  StartCongratulationsView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 17.11.2021.
//

import UIKit
import EasyPeasy

protocol StartCongratulationsViewDelegate: AnyObject {
    func startButtonTapped()
}


final class StartCongratulationsView: UIView {
    
    weak var delegate: StartCongratulationsViewDelegate?
    
    private let congratsLabel: UILabel = {
        let label = UILabel()
        label.text = "Поздравляем 🎉"
        label.font = .systemFont(ofSize: 31, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let congratsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "hands.sparkles.fill")
        imageView.tintColor = .accentColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let endSmokeDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 31, weight: .semibold)
        label.textColor = .black
        label.text = "29-03-2020"
        return label
    }()
    
    private let endSmokeDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Это дата - конец твоих отношений\n с сигаретами. Ты их бросаешь.\n И никогда не позвонишь!"
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.accentColor, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .white
        button.layer.borderWidth = 2.5
        button.layer.borderColor = UIColor(red: 254/255, green: 168/255, blue: 59/255, alpha: 1).cgColor
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    @objc private func startButtonTapped() {
        delegate?.startButtonTapped()
    }
    
    private func setupViews() {
        let allViews = [congratsLabel,
                        congratsImageView,
                        endSmokeDateLabel,
                        endSmokeDescriptionLabel,
                        startButton]
        allViews.forEach {
            addSubview($0)
        }
    }
    
    private func setupLayout() {
        congratsLabel.easy.layout(
            Top(90),
            CenterX()
        )
        
        congratsImageView.easy.layout(
            Top(70).to(congratsLabel),
            Height(140),
            CenterX()
        )
        
        endSmokeDateLabel.easy.layout(
            Top(70).to(congratsImageView),
            CenterX()
        )
        
        endSmokeDescriptionLabel.easy.layout(
            Top(20).to(endSmokeDateLabel),
            CenterX()
        )
        
        startButton.easy.layout(
            Bottom(60),
            CenterX(),
            Width(280),
            Height(50)
        )
    }
}
