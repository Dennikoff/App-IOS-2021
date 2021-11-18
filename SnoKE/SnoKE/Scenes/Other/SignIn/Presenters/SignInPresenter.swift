//
//  SignInPresenter.swift
//  SnoKE
//
//  Created by Денис Харке on 16.11.2021.
//

import UIKit

protocol SignInPresenterProtocol:AnyObject{
    func showSignUpScreen(_ vc: UIViewController)
    func signIn<T: AuthViewControllerProtocol & UIViewController>(_ vc: T, email: String, password: String)
}

final class SignInPresenter:SignInPresenterProtocol{
    func signIn<T: AuthViewControllerProtocol & UIViewController>(_ vc: T, email: String, password: String) {
        AuthManager.shared.signIn(vc, email: email, password: password)
    }
    
    func showSignUpScreen(_ vc: UIViewController) {
        let signUpPresenter = SignUpPresenter()
        let signUpVC = SignUpViewController(presenter: signUpPresenter)
        signUpVC.modalPresentationStyle = .fullScreen
        vc.present(signUpVC, animated: false)
    }
    
    
}
