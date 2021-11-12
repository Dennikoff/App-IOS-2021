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
    
    private let signUpView = SignUpView()
    
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
        AuthManager.shared.signUpUser(self, email: email, password: password) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(to: .mainState)
        }
        
    }
    
    func loginButtonTapped() {
        print("💞 login button tapped")
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
