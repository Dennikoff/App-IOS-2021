//
//  SignUpPresenter.swift
//  SnoKE
//
//  Created by Ilya Buldin on 13.11.2021.
//

import UIKit


protocol SignUpPresenterProtocol {
    func signUpUser(_ vc: SignUpViewControllerProtocol, email: String, password: String)
    func showSignInScreen(_ vc: UIViewController)
}

final class SignUpPresenter: SignUpPresenterProtocol {
    
    func signUpUser(_ vc: SignUpViewControllerProtocol, email: String, password: String) {
        AuthManager.shared.signUpUser(vc, email: email, password: password) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(to: .mainState)
        }
    }
    
    func showSignInScreen(_ vc: UIViewController) {
        let signInVC = SignInViewController()
        signInVC.modalPresentationStyle = .fullScreen
        vc.present(signInVC, animated: true)
    }

}
