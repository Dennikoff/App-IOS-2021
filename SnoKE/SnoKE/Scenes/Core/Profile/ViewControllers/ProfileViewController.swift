//
//  ProfileViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выйти из аккаунта", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .red
        button.titleLabel?.textColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubview(logoutButton)
        logoutButton.frame = CGRect(x: view.width/4, y: view.height/2, width: 250, height: 60)
        logoutButton.addTarget(self, action: #selector(didTappedLogoutButton), for: .touchUpInside)
    }

    @objc private func didTappedLogoutButton() {
        AuthManager.shared.logout() {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(to: .signUpState)
        }
    }
}
