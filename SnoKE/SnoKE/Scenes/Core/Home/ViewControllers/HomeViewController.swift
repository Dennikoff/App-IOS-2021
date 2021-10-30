//
//  HomeViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import SwiftUI
import EasyPeasy

class HomeViewController: UIViewController {

    private var homePresenter: HomePresenterProtocol?
    
    private lazy var timeWithoutSmokingView: TimeWithoutSmokingView = {
        let view = TimeWithoutSmokingView()
        return view
    }()
    
    private lazy var savedMoneyView: SecondaryTrackerView = {
        let view = SecondaryTrackerView()
        return view
    }()
    
    private lazy var brokenCigarettesView: SecondaryTrackerView = {
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
    
    private lazy var moreAchievementsButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 19, weight: .bold))
        button.setImage(UIImage(systemName: "chevron.right", withConfiguration: imageConfig), for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.4, alpha: 1)
        button.imageView?.tintColor = .white
        return button
    }()
    
    private lazy var userWantsToSmokeButton: UserWantsToSmokeButton = {
        let button = UserWantsToSmokeButton()
        return button
    }()
    
    private lazy var userSmokedButton: UserSmokedButton = {
        let button = UserSmokedButton()
        return button
    }()
    
    let model = SecondaryTrackerModel(type: .savedMoney, number: 322, icon: "paymentIcon")
    let model2 = SecondaryTrackerModel(type: .brokenCigarettes, number: 322, icon: "brokenCigarette")
    
    
    
    init(presenter: HomePresenterProtocol?) {
        self.homePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        savedMoneyView.configure(with: model)
        brokenCigarettesView.configure(with: model2)
        timeWithoutSmokingView.configure(digits: (days: (0, 8), hours: (1, 7), minutes: (2, 3)))
        moreAchievementsButton.addTarget(self, action: #selector(coolButtonTapped), for: .touchUpInside)
        userWantsToSmokeButton.addTarget(self,
                                         action: #selector(userWantsToSmokeButtonTapped),
                                         for: .touchUpInside)
        userSmokedButton.addTarget(self, action: #selector(userSmokedButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupLayout()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        let views = [timeWithoutSmokingView,
                     savedMoneyView,
                     brokenCigarettesView,
                     headerLabel,
                     lastAchievementView,
                     moreAchievementsButton,
                     userWantsToSmokeButton,
                     userSmokedButton]
        views.forEach {
            view.addSubview($0)
        }
    }
    
    private func setupLayout() {
        timeWithoutSmokingView.easy.layout(
            Height(175),
            Right(16),
            Left(16),
            Top(0).to(navigationController?.navigationBar.safeAreaLayoutGuide ?? UILayoutGuide())
        )
        
        savedMoneyView.easy.layout(
            Height(50),
            Left(16),
            Width((view.width - 16 * 2 - 12) / 2),
            Top(12).to(timeWithoutSmokingView)
        )
        
        brokenCigarettesView.easy.layout(
            Height(50),
            Right(16),
            Width((view.width - 16 * 2 - 12) / 2),
            Top(12).to(timeWithoutSmokingView)
        )
        
        headerLabel.easy.layout(
            Top(12).to(savedMoneyView),
            Left(16)
        )
        
        lastAchievementView.easy.layout(
            Width((view.width - 44) * 2/3),
            Height(100),
            Left(16),
            Top(12).to(headerLabel)
        )
        
        moreAchievementsButton.easy.layout(
            Width((view.width - 44) * 1/3),
            Height(100),
            Right(16),
            Top(12).to(headerLabel)
        )
        
        userWantsToSmokeButton.easy.layout(
            Width((view.width - 44) * 2/3),
            Height(100),
            Left(16),
            Top(12).to(lastAchievementView)
        )
        
        userSmokedButton.easy.layout(
            Width((view.width - 44) * 1/3),
            Height(100),
            Right(16),
            Top(12).to(moreAchievementsButton)
        )
            
    }
    
    @objc func coolButtonTapped() {
        homePresenter?.moreAchievementsButtonTapped()
    }
    
    @objc func userWantsToSmokeButtonTapped() {
        homePresenter?.userWantsToSmokeButtonTapped()
    }
    
    @objc func userSmokedButtonTapped() {
        homePresenter?.userSmokedButtonTapped()
    }
}

