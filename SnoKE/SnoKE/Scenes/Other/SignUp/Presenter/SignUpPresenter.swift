//
//  SignUpPresenter.swift
//  SnoKE
//
//  Created by Ilya Buldin on 13.11.2021.
//

import UIKit


protocol SignUpPresenterProtocol {
    func signUpUser<T: UIViewController & AuthViewControllerProtocol>(_ vc: T, email: String, password: String)
    func showSignInScreen(_ vc: UIViewController)
}

final class SignUpPresenter: SignUpPresenterProtocol {
    
    func signUpUser<T: UIViewController & AuthViewControllerProtocol>(_ vc: T, email: String, password: String) {
        AuthManager.shared.signUpUser(vc, email: email, password: password) {
            let startFormVC = StartFormViewController(presenter: StartFormPresenter())
            startFormVC.modalPresentationStyle = .fullScreen
            vc.present(startFormVC, animated: true)
        }
    }
    
    func showSignInScreen(_ vc: UIViewController) {
        let signInVC = SignInViewController()
        signInVC.modalPresentationStyle = .fullScreen
        vc.present(signInVC, animated: false)
    }

}
