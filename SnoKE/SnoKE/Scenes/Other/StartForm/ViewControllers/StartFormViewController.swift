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
    func enterButtonTapped(numberPerDay: String, packPrice: String, numberInPack: String) {
        UserDefaults.standard.set(numberPerDay, forKey: "com.SnoKEapp.SnoKE.numberPerDay")
        UserDefaults.standard.set(packPrice, forKey: "com.SnoKEapp.SnoKE.packPrice")
        UserDefaults.standard.set(numberInPack, forKey: "com.SnoKEapp.SnoKE.numberInPack")
        
        let df = DateFormatter()
        df.dateFormat = "dd-MM-YYYY"
        let finishSmokingDateStr = df.string(from: Date())
        UserDefaults.standard.setValue(finishSmokingDateStr, forKey: "com.SnoKEapp.SnoKE.finishSmokingDate")

        presenter?.showStartCongratulationsScreen(self)
    }
    
    
    func showNotAllFilledAlert() {
        presenter?.showNotAllFormsFilledAlert(self)
    }
}
