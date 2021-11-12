//
//  SignInViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy

final class SignInViewController: UIViewController {
    
    let signInView = SignInView()
    
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
        if (mail == "Test" && password == "Test"){
            signInView.showMessageGood()
        } else {
            signInView.showMessageBad()
        }
    }
    
    func signUpButtonTapped() {
        print("SignUp button tapped")
    }

    
}
