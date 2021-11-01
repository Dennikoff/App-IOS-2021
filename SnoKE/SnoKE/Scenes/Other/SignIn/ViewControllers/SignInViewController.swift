//
//  SignInViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy

class SignInViewController: UIViewController {
    
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
    func enterButtonTapped(_ mail:String, _ password: String) {
        if (mail == "Test" && password == "Test"){
            signInView.showMessageGood()
        } else {
            signInView.showMessageBad()
        }
        print("Enter button tapped")
    }
    
    func signUpButtonTapped() {
        print("SignUp button tapped")
    }

    
}
