//
//  SignInViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy

final class SignInViewController: UIViewController {
    
    private let signInView = SignInView()
    
    private var presenter: SignInPresenterProtocol = SignInPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(signInView)
        signInView.frame = view.frame
        signInView.delegate = self
    }

}

extension SignInViewController: SignInViewDelegate{
    func forgetPasswordTapped() {
        print("ForgetPassword button tapped")
    }
    
    func enterButtonTapped(_ mail:String, _ password: String) {
        presenter.signIn(self, email: mail, password: password)
    }
    
    func signUpButtonTapped() {
        presenter.showSignUpScreen(self)
    }
}


extension SignInViewController: AuthViewControllerProtocol {
    func showSignUpErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Что-то пошло не так...",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
