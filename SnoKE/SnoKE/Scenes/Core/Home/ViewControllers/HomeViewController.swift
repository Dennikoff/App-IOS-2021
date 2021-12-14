//
//  HomeViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import SwiftUI
import EasyPeasy
import FirebaseAuth

class HomeViewController: UIViewController {

    // MARK: - Properties
    private var homePresenter: HomePresenterProtocol?
    
    private let mainView = HomeView()
    
    private var model: TimeWithoutSmokingModel
    
    private var timer: Timer = Timer()
    
    // MARK: - Init
    init(presenter: HomePresenterProtocol) {
        self.homePresenter = presenter
        self.model = HomeService.shared.getCurrentTimeWithoutSmoking()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.model = HomeService.shared.getCurrentTimeWithoutSmoking()
        super.init(coder: coder)
        
    }
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] _ in
            self?.updateUI()
        })
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        mainView.savedMoneyView.configure(with: SecondaryTrackerModel.init(type: .savedMoney))
        mainView.brokenCigarettesView.configure(with: SecondaryTrackerModel.init(type: .brokenCigarettes))
        let modelDays = model.days
        let hoursModel = model.hours
        let minModel = model.minutes
        mainView.timeWithoutSmokingView.configure(digits: (days: (modelDays.firstDigit, modelDays.secondDigit),
                                                           hours: (hoursModel.firstDigit, hoursModel.secondDigit),
                                                           minutes: (minModel.firstDigit, minModel.secondDigit)))
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
    
    private func updateUI() {
        self.model = HomeService.shared.getCurrentTimeWithoutSmoking()
        mainView.timeWithoutSmokingView.configure(digits: (days: (model.days.firstDigit, model.days.secondDigit),
                                                           hours: (model.hours.firstDigit, model.hours.secondDigit),
                                                           minutes: (model.minutes.firstDigit, model.minutes.secondDigit)))
    }
}
