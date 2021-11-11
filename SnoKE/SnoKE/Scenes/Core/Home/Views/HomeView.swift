//
//  HomeView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 31.10.2021.
//

import UIKit
import EasyPeasy

class HomeView: UIView {

    // MARK: - Properties
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var firstBackgroundCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = #colorLiteral(red: 0.9529411765, green: 0.9764705882, blue: 0.8862745098, alpha: 1)
        return imageView
    }()
    
    private lazy var secondBackgroundCircle: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = #colorLiteral(red: 0.9529411765, green: 0.9764705882, blue: 0.8862745098, alpha: 1)
        return imageView
    }()
    
    lazy var timeWithoutSmokingView: TimeWithoutSmokingView = {
        let view = TimeWithoutSmokingView()
        return view
    }()
    
    lazy var savedMoneyView: SecondaryTrackerView = {
        let view = SecondaryTrackerView()
        return view
    }()
    
    lazy var brokenCigarettesView: SecondaryTrackerView = {
        let view = SecondaryTrackerView()
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.text = "Мои достижения"
        return label
    }()
    
    private lazy var lastAchievementView: LastAchievementView = {
       let view = LastAchievementView()
       return view
    }()
    
    lazy var moreAchievementsButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 19, weight: .bold))
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: imageConfig), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.4, alpha: 1)
        button.imageView?.tintColor = .white
        return button
    }()
    
    lazy var userWantsToSmokeButton: UserWantsToSmokeButton = {
        let button = UserWantsToSmokeButton()
        return button
    }()
    
    lazy var userSmokedButton: UserSmokedButton = {
        let button = UserSmokedButton()
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupViews() {
        backgroundColor = .systemBackground
        addSubview(scrollView)
        addSubview(firstBackgroundCircle)
        addSubview(secondBackgroundCircle)
        
        scrollView.addSubview(containerView)
        
        let views = [timeWithoutSmokingView,
                     savedMoneyView,
                     brokenCigarettesView,
                     headerLabel,
                     lastAchievementView,
                     moreAchievementsButton,
                     userWantsToSmokeButton,
                     userSmokedButton]
        views.forEach {
            containerView.addSubview($0)
        }
        
    }
    
    
    private func setupLayout() {
        scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        containerView.easy.layout(
            CenterX(),
            CenterY(),
            Left(0),
            Right(0),
            Top(0),
            Bottom(0)
        )
        
        firstBackgroundCircle.easy.layout(
            Size(600),
            Center(CGPoint(x: width / 2, y: -(height / 2.5)))
        )
        
        secondBackgroundCircle.easy.layout(
            Size(600),
            Center(CGPoint(x: -width / 2, y: height / 2.5))
        )
        
        // solving conflict of adding scrollView and these background imageViews
        // this conflict forced navBar title mode not to collaple when scrolling up
        firstBackgroundCircle.layer.zPosition = -1
        secondBackgroundCircle.layer.zPosition = -1
        
        
        timeWithoutSmokingView.easy.layout(
            Height(175),
            Right(16),
            Left(16),
            Top(0)
        )
        
        savedMoneyView.easy.layout(
            Height(50),
            Left(16),
            Width((width - 16 * 2 - 12) / 2),
            Top(12).to(timeWithoutSmokingView)
        )
        
        brokenCigarettesView.easy.layout(
            Height(50),
            Right(16),
            Width((width - 16 * 2 - 12) / 2),
            Top(12).to(timeWithoutSmokingView)
        )
        
        headerLabel.easy.layout(
            Top(12).to(savedMoneyView),
            Left(16)
        )
        
        lastAchievementView.easy.layout(
            Width((width - 44) * 2/3),
            Height(100),
            Left(16),
            Top(12).to(headerLabel)
        )
        
        moreAchievementsButton.easy.layout(
            Width((width - 44) * 1/3),
            Height(100),
            Right(16),
            Top(12).to(headerLabel)
        )
        
        userWantsToSmokeButton.easy.layout(
            Width((width - 44) * 2/3),
            Height(100),
            Left(16),
            Top(12).to(lastAchievementView)
        )
        
        userSmokedButton.easy.layout(
            Width((width - 44) * 1/3),
            Height(100),
            Right(16),
            Top(12).to(moreAchievementsButton)
        )
            
    }
}
