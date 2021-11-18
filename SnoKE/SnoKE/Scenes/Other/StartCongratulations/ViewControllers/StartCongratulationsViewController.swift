//
//  StartCongratulationsViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 17.11.2021.
//

import UIKit

final class StartCongratulationsViewController: UIViewController {
    
    private let startCongratulationsView = StartCongratulationsView()
    
    private var presenter: StartCongratulationsPresenterProtocol?
    
    init(presenter: StartCongratulationsPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = startCongratulationsView

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        startCongratulationsView.configure()
        startCongratulationsView.delegate = self
    }
    
}


extension StartCongratulationsViewController: StartCongratulationsViewDelegate {
    func startButtonTapped() {
        presenter?.showMainFlow()
    }
    
}
