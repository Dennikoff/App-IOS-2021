//
//  HomeViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import SwiftUI
import EasyPeasy

class HomeViewController: UIViewController {

    // MARK: - Properties
    private var homePresenter: HomePresenterProtocol?
    
    private let mainView = HomeView()
    
    let model = SecondaryTrackerModel(type: .savedMoney, number: 322)
    let model2 = SecondaryTrackerModel(type: .brokenCigarettes, number: 322)
    
    
    // MARK: - Init
    init(presenter: HomePresenterProtocol) {
        self.homePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mainView.savedMoneyView.configure(with: model)
        mainView.brokenCigarettesView.configure(with: model2)
        mainView.timeWithoutSmokingView.configure(digits: (days: (0, 8), hours: (1, 7), minutes: (2, 3)))
        mainView.moreAchievementsButton.addTarget(self, action: #selector(coolButtonTapped), for: .touchUpInside)
        mainView.userWantsToSmokeButton.addTarget(self,
                                                  action: #selector(userWantsToSmokeButtonTapped),
                                                  for: .touchUpInside)
        mainView.userSmokedButton.addTarget(self, action: #selector(userSmokedButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Methods
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
