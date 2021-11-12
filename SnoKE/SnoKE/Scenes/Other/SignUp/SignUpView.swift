//
//  SignUpView.swift
//  SnoKE
//
//  Created by Кристина Шляпкина on 01.11.2021.
//

import SwiftUI
import TextFieldEffects
import EasyPeasy

protocol SignUpViewDelegate: AnyObject {
    func signUpButtonTapped()
    func loginButtonTapped()
}


class SignUpView: UIView {
    
    // MARK: - Properties
    weak var delegate: SignUpViewDelegate?
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Извините, но кто вы? Впервые вижу!"
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "signUpScissors")
        return imageView
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти в систему", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.alpha = 0.5
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var emailContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .none
        return view
    }()
    
    private let mailTextField: HoshiTextField = {
        let textField = HoshiTextField()
        textField.placeholder = "Почта"
        textField.placeholderFontScale = 1
        textField.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        textField.borderInactiveColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private var passwordContainer: UIView = {
        let container = UIView()
        container.layer.cornerRadius = 8
        container.backgroundColor = .none
        return container
    }()
    
    private let passwordTextField: HoshiTextField = {
        let textField = HoshiTextField()
        textField.placeholder = "Пароль"
        textField.isSecureTextEntry = true
        textField.placeholderFontScale = 1
        textField.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        textField.borderInactiveColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let buttonShowPassword: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(showPassword), for: .touchDown)
        button.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        return button
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.backgroundColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: -Methods
    func setupView() {
        addSubview(backgroundImage)
        backgroundImage.easy.layout(
            Right(40),
            Top(50),
            Left(150)
        )
        
        addSubview(welcomeLabel)
        welcomeLabel.easy.layout(
            Left(40),
            Right(50),
            Height(150),
            Top((UIApplication.shared.windows.first?.safeAreaInsets.top ?? .zero) + 122)
        )
        
        addSubview(emailContainer)
        emailContainer.easy.layout(
            Left(40),
            Right(40),
            Top(40).to(welcomeLabel),
            Height(50)
        )
        
        emailContainer.addSubview(mailTextField)
        mailTextField.easy.layout(
            Left(10),
            Right(10),
            Height(50),
            Top()
        )
        
        addSubview(passwordContainer)
        passwordContainer.easy.layout(
            Left(40),
            Right(40),
            Top(10).to(emailContainer),
            Height(50)
        )
        
        passwordContainer.addSubview(passwordTextField)
        passwordTextField.easy.layout(
            Left(10),
            Right(10),
            Height(50),
            Top()
        )
        
        passwordContainer.addSubview(buttonShowPassword)
        buttonShowPassword.easy.layout(
            Right(5),
            Width(25),
            Height(20),
            Bottom(10)
        )
        
        addSubview(signUpButton)
        signUpButton.easy.layout(
            CenterX(),
            Top(50).to(passwordContainer),
            Size(CGSize(width: 300, height: 45))
        )
        
        addSubview(loginButton)
        loginButton.easy.layout(
            CenterX(),
            Bottom(50),
            Height(46)
        )

        
    }
    
    
    @objc private func hidePassword() {
        passwordTextField.isSecureTextEntry = true
        buttonShowPassword.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
    }
    
    @objc private func showPassword() {
        passwordTextField.isSecureTextEntry = false
        buttonShowPassword.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    @objc private func signUpButtonTapped() {
        delegate?.signUpButtonTapped()
        print("📝 sign up button tapped")
    }
    
    @objc private func loginButtonTapped() {
        delegate?.loginButtonTapped()
        print("💞 login button tapped")
    }
}

//struct SighUpView_Preview: PreviewProvider {
//    static var previews: some View {
//        ViewPreview {
//            SignUpView()
//        }
//    }
//}
