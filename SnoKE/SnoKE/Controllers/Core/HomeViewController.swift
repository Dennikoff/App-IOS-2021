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

    let cool = SecondaryTrackerView(frame: CGRect(x: 50, y: 390, width: 166, height: 48))
    let cool2 = SecondaryTrackerView(frame: CGRect(x: 230, y: 390, width: 166, height: 48))
    
    let doom = TimeWithoutSmokingView(frame: CGRect(x: 50, y: 200, width: 343, height: 175))
    let achTitle = UILabel()
    
    let viewModel = SecondaryTrackerViewModel(type: .savedMoney, number: 322, icon: "paymentIcon")
    let viewModel2 = SecondaryTrackerViewModel(type: .brokenCigarettes, number: 322, icon: "brokenCigarette")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cool)
        view.addSubview(doom)
        view.addSubview(cool2)
        view.addSubview(achTitle)
        achTitle.text = "Мои достижения"
        achTitle.textColor = .black
        achTitle.frame = CGRect(x: 50, y: 450, width: 200, height: 20)
        cool.configure(with: viewModel)
        cool2.configure(with: viewModel2)
        doom.configure(digits: (days: (0, 8), hours: (1, 7), minutes: (2, 3)))
        view.backgroundColor = .systemBackground
    }
    

}
