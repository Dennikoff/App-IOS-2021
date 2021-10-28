//
//  HomeViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    // мне впадлу нормально делать этот вью контроллер поэтому пока что
    // фреймами через жопу
    
    private var homePresenter: HomePresenterProtocol?

    let cool = SecondaryTrackerView(frame: CGRect(x: 50, y: 390, width: 166, height: 48))
    let cool2 = SecondaryTrackerView(frame: CGRect(x: 230, y: 390, width: 166, height: 48))
    
    let doom = TimeWithoutSmokingView(frame: CGRect(x: 50, y: 200, width: 343, height: 175))
    let achTitle = UILabel()
    
    let viewModel = SecondaryTrackerModel(type: .savedMoney, number: 322, icon: "paymentIcon")
    let viewModel2 = SecondaryTrackerModel(type: .brokenCigarettes, number: 322, icon: "brokenCigarette")
    
    let coolButton = UIButton()
    
    init(presenter: HomePresenterProtocol) {
        self.homePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cool)
        view.addSubview(doom)
        view.addSubview(cool2)
        view.addSubview(achTitle)
        view.addSubview(coolButton)
        achTitle.text = "Мои достижения"
        achTitle.textColor = .black
        achTitle.frame = CGRect(x: 50, y: 450, width: 200, height: 20)
        coolButton.frame = CGRect(x: 150, y: 550, width: 200, height: 50)
        coolButton.setTitle("hit me", for: .normal)
        coolButton.backgroundColor = .orange
        coolButton.addTarget(self, action: #selector(coolButtonTapped), for: .touchUpInside)
        cool.configure(with: viewModel)
        cool2.configure(with: viewModel2)
        doom.configure(digits: (days: (0, 8), hours: (1, 7), minutes: (2, 3)))
        view.backgroundColor = .systemBackground
    }
    
    @objc func coolButtonTapped() {
        homePresenter?.moreAchievementsButtonTapped()
    }
}
