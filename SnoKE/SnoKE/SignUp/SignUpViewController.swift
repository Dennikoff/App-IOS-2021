//
//  SignUpViewController.swift
//  SnoKE
//
//  Created by Kristina Shlyapkina on 23.10.2021.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Properties

    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.numberOfLines = 0
        label.text = "Извините, но кто вы? Впервые вижу!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "signUpScissors")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти в систему", for: .normal)
//        button.UIColor(.black, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let loginTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Имя пользователя"
        return field
    }()

    private let mailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Почта"
        return field
    }()

    private let passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Пароль"
        return field
    }()

    private let fieldsStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: UIFont.Weight(300))
        button.backgroundColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    func setupView() {
        view.addSubview(backgroundImage)
        backgroundImage.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 91).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 102).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -17).isActive = true

        view.addSubview(welcomeLabel)
        welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 122).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true

        fieldsStackView.addArrangedSubview(loginTextField)
        fieldsStackView.addArrangedSubview(mailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        view.addSubview(fieldsStackView)
        fieldsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        fieldsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        fieldsStackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 75).isActive = true

        view.addSubview(signUpButton)
        signUpButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 47).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47).isActive = true
        signUpButton.topAnchor.constraint(lessThanOrEqualTo: fieldsStackView.bottomAnchor, constant: 60).isActive = true

        view.addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
    }
}

struct SignUpViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            SignUpViewController()
        }
    }
}
