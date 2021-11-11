//
//  SignUpView.swift
//  SnoKE
//
//  Created by Кристина Шляпкина on 01.11.2021.
//

import SwiftUI
import TextFieldEffects

class SignUpView: UIView {
    
    // MARK: - Properties
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.numberOfLines = 0
        label.text = "Извините, но кто вы? Впервые вижу!"
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
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0.5
        return button
    }()
    
    private let loginTextField: HoshiTextField = {
        $0.placeholder = "Имя пользователя"
        $0.placeholderFontScale = 1
        $0.alpha = 0.5
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
    private let mailTextField: HoshiTextField = {
        $0.placeholder = "Почта"
        $0.placeholderFontScale = 1
        $0.alpha = 0.5
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
    private let passwordTextField: HoshiTextField = {
        $0.placeholder = "Пароль"
        $0.isSecureTextEntry = true
        $0.placeholderFontScale = 1
        $0.alpha = 0.5
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = UIColor(red: 122/255, green: 122/255, blue: 122/255, alpha: 1)
        
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.backgroundColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        addSubview(backgroundImage)
        backgroundImage.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 91).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 102).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17).isActive = true
        
        addSubview(welcomeLabel)
        welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: topAnchor, constant: 122).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        
        fieldsStackView.addArrangedSubview(loginTextField)
        fieldsStackView.addArrangedSubview(mailTextField)
        fieldsStackView.addArrangedSubview(passwordTextField)
        addSubview(fieldsStackView)
        fieldsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        fieldsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        fieldsStackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 75).isActive = true
        
        addSubview(signUpButton)
        signUpButton.heightAnchor.constraint(equalToConstant: 49).isActive = true
        signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 47).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -47).isActive = true
        signUpButton.topAnchor.constraint(lessThanOrEqualTo: fieldsStackView.bottomAnchor, constant: 60).isActive = true
        
        addSubview(loginButton)
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
        
    }
}

struct SighUpView_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            SignUpView()
        }
    }
}
