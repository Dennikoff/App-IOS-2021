//
//  HzViewController.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit
import FirebaseAuth

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
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let currentUserID = currentUser.uid
        
        // TODO: сделать не форс анрап
        AuthManager.shared.fillAdditionalUserInfo(to: currentUser, cigarettesPerDay: Int(numberPerDay)!, cigarettesInPack: Int(numberInPack)!, packPrice: Int(packPrice)!)
        
        UserDefaults.standard.set(numberPerDay, forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(currentUserID)")
        UserDefaults.standard.set(packPrice, forKey: "com.SnoKEapp.SnoKE.packPrice.\(currentUserID)")
        UserDefaults.standard.set(numberInPack, forKey: "com.SnoKEapp.SnoKE.numberInPack.\(currentUserID)")
        
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        df.locale = Locale(identifier: "ru_RU")
        let finishSmokingDate = Date()
        UserDefaults.standard.setValue(finishSmokingDate, forKey: "com.SnoKEapp.SnoKE.finishSmokingDate.\(currentUserID)")

        presenter?.showStartCongratulationsScreen(self)
    }
    
    
    func showNotAllFilledAlert() {
        presenter?.showNotAllFormsFilledAlert(self)
    }
}
