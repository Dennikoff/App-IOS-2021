//
//  HzViewController.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit

final class StartFormViewController: UIViewController {
    
    private var startFormView = StartFormView()
    
    private var presenter: StartFormPresenterProtocol?
    
    init(presenter: StartFormPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = startFormView
        startFormView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}


extension StartFormViewController: StartFormViewDelegate {
    func enterButtonTapped() {
        presenter?.showStartCongratulationsScreen(self)
    }
    
    func showNotAllFilledAlert() {
        presenter?.showNotAllFormsFilledAlert(self)
    }
}
