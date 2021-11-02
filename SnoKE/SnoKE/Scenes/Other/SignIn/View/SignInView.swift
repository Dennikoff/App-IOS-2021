//
//  SignInView.swift
//  SnoKE
//
//  Created by Денис Харке on 01.11.2021.
//

import UIKit
import EasyPeasy
import TextFieldEffects

protocol SignInViewDelegate:AnyObject{
    func enterButtonTapped(_ mail:String, _ password:String)
    func signUpButtonTapped()
    func forgetPasswordTapped()
}

class SignInView: UIView {
    var k = 0.0
    
    weak var delegate: SignInViewDelegate?
    
    private let myImage: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "cigarette slash")
        return $0
    }(UIImageView())
    
    private let buttonEnter: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        //button.set(.darkGray, for: .normal)
        $0.backgroundColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let buttonForgetPassword: UIButton = {
        $0.setTitle("Забыли пароль?", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        //button.set(.darkGray, for: .normal)
        $0.backgroundColor = .none
        $0.addTarget(self, action: #selector(forgetPasswordTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let buttonSignUp: UIButton = {
        $0.setTitle("Зарегистрироваться", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        //button.set(.darkGray, for: .normal)
        $0.backgroundColor = .none
        $0.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let buttonShowPassword: UIButton = {
        let bt = UIButton()
        $0.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
        $0.addTarget(self, action: #selector(showPassword), for: .touchDown)
        $0.addTarget(self, action: #selector(hidePassword), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var emailContainer: UIView = {
        //$0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private var passwordContainer: UIView = {
        //$0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .none
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let badMessageLabel:UILabel = {
        $0.text = "Не узнаю вас, попробуйте ввести данные снова"
        $0.numberOfLines = 0
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isHidden = true
        return $0
    }(UILabel())
    
    private let goodMessageLabel:UILabel = {
        $0.text = "Доброго времени суток"
        $0.numberOfLines = 0
        $0.textColor = .green
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.isHidden = true
        return $0
    }(UILabel())
    
    lazy var label:UILabel = {
        $0.text = "Кто вы?\nНемедленно назовитесь"
        $0.numberOfLines = 0
        $0.layer.cornerRadius = 12
        $0.textColor = .black
        return $0
    }(UILabel())
    
    private let textFieldUserName: HoshiTextField = {
        $0.placeholder = "Почта"
        //let txt = UITextField(frame: CGRect(origin: CGPoint(x: 10, y:20), size:CGSize(width: 40, height: 10)), primaryAction: nil)
        $0.placeholderFontScale = 1.0
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = .black
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
    private let textFieldPassword: HoshiTextField = {
        $0.placeholder = "Пароль"
        //let txt = UITextField(frame: CGRect(origin: CGPoint(x: 10, y:20), size:CGSize(width: 40, height: 10)), primaryAction: nil)
        $0.isSecureTextEntry = true
        $0.placeholderFontScale = 1.0
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = .black
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())

    override init(frame: CGRect) {
        super.init(frame: frame)
        emailContainer.addSubview(textFieldUserName)
        passwordContainer.addSubview(textFieldPassword)
        passwordContainer.addSubview(buttonShowPassword)
        [myImage, label,buttonEnter, buttonForgetPassword, buttonSignUp, emailContainer, passwordContainer, badMessageLabel, goodMessageLabel].forEach {
            self.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setlayout()
        k = self.width
        label.font = UIFont.systemFont(ofSize:k / 8.56, weight: .bold)
    }
    
    private func setlayout(){
        myImage.easy.layout(
            Right(40),
            Top(-50),
            Left(150)
        )
        badMessageLabel.easy.layout(
            Left(40),
            Top(20).to(label)
        )
        goodMessageLabel.easy.layout(
            Left(40),
            Top(20).to(label)
        )
        label.easy.layout(
            Left(40),
            Right(50),
            Top((UIApplication.shared.windows.first?.safeAreaInsets.top ?? .zero)+122)
        )
        emailContainer.easy.layout(
            Left(40),
            Right(40),
            Top(20).to(badMessageLabel),
            Height(50)
        )
        textFieldUserName.easy.layout(
            Left(10),
            Right(10),
            Height(50)
        )
        passwordContainer.easy.layout(
            Left(40),
            Right(40),
            Top(10).to(emailContainer),
            Height(50)
        )
        textFieldPassword.easy.layout(
            Left(10),
            Right(10),
            Height(50)
        )
        buttonShowPassword.easy.layout(
            Right(5),
            Width(25),
            Height(20),
            Bottom(10)
        )
        buttonEnter.easy.layout(
            CenterX(),
            Top(50).to(passwordContainer),
            Size(CGSize(width: 300, height: 45))
        )
        buttonSignUp.easy.layout(
            CenterX(),
            Bottom(10).to(buttonForgetPassword)
        )
        buttonForgetPassword.easy.layout(
            CenterX(),
            Bottom(UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? .zero)
        )
    }
    @objc
    func enterButtonTapped(){
        //guard let сделать
        let mail = textFieldUserName.text
        let password = textFieldPassword.text
        delegate?.enterButtonTapped(mail!, password!)
    }
    @objc
    func hidePassword(){
        textFieldPassword.isSecureTextEntry = true
        buttonShowPassword.setBackgroundImage(UIImage(systemName: "eye"), for: .normal)
    }
    @objc
    func showPassword(){
        textFieldPassword.isSecureTextEntry = false
        buttonShowPassword.setBackgroundImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    @objc
    func signUpButtonTapped(){
        delegate?.signUpButtonTapped()
    }
    @objc
    func forgetPasswordTapped(){
        delegate?.forgetPasswordTapped()
    }
    func showMessageBad(){
        badMessageLabel.isHidden = false
        goodMessageLabel.isHidden = true
    }
    
    func showMessageGood(){
        badMessageLabel.isHidden = true
        goodMessageLabel.isHidden = false
    }
}
