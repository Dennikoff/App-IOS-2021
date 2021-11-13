//
//  SignUpViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import SwiftUI

protocol SignUpViewControllerProtocol {
    func showSignUpErrorAlert(with message: String)
}


final class SignUpViewController: UIViewController {
    
    private let presenter: SignUpPresenterProtocol? 
    
    private let signUpView = SignUpView()
    
    init(presenter: SignUpPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.delegate = self
    }
    
}


extension SignUpViewController: SignUpViewDelegate {
    func signUpButtonTapped(email: String, password: String) {
        presenter?.signUpUser(self, email: email, password: password)
    }
    
    func loginButtonTapped() {
        presenter?.showSignInScreen(self)
    }
}

extension SignUpViewController: SignUpViewControllerProtocol {
    func showSignUpErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Что-то пошло не так...",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}



//struct SignUpViewController_Previews: PreviewProvider {
//     static var previews: some View {
//         ViewControllerPreview {
//             SignUpViewController()
//         }
//     }
// }
