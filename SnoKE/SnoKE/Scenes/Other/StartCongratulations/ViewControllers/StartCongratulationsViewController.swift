//
//  StartCongratulationsViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 17.11.2021.
//

import UIKit
import FirebaseAuth

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
        addDateToFirebase()
        startCongratulationsView.configure()
        startCongratulationsView.delegate = self
    }
    
    func addDateToFirebase() {
        guard let currentUser = Auth.auth().currentUser, let finishSmokingDate = UserDefaults.standard.object(forKey: "com.SnoKEapp.SnoKE.finishSmokingDate.\(currentUser.uid)") as? Date else {

            return
        }
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let finishSmokingDateStr = df.string(from: finishSmokingDate)
        AuthManager.shared.addFinishSmokingDateToUserStorage(user: currentUser, finishDate: finishSmokingDateStr)
    }
    
}


extension StartCongratulationsViewController: StartCongratulationsViewDelegate {
    func startButtonTapped() {
        presenter?.showMainFlow()
    }
    
}
