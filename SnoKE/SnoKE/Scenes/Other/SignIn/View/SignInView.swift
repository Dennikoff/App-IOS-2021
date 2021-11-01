//
//  SignInView.swift
//  SnoKE
//
//  Created by Денис Харке on 01.11.2021.
//

import UIKit
import EasyPeasy

protocol SignInViewDelegate:AnyObject{
    func enterButtonTapped(_ mail:String, _ password:String)
    func signUpButtonTapped()
}

class SignInView: UIView {

    weak var delegate: SignInViewDelegate?
    private let buttonEnter: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        //button.set(.darkGray, for: .normal)
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
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
    
    let label:UILabel = {
        $0.text = "Кто вы?\nНемедленно\nназовитесь"
        $0.numberOfLines = 0
        $0.layer.cornerRadius = 12
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize:50)
        return $0
    }(UILabel())
    
    private let textFieldUserName: UITextField = {
        $0.placeholder = "Почта"
        //let txt = UITextField(frame: CGRect(origin: CGPoint(x: 10, y:20), size:CGSize(width: 40, height: 10)), primaryAction: nil)
        return $0
    }(UITextField())
    
    private let textFieldPassword: UITextField = {
        $0.placeholder = "Пароль"
        //let txt = UITextField(frame: CGRect(origin: CGPoint(x: 10, y:20), size:CGSize(width: 40, height: 10)), primaryAction: nil)
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())

    override init(frame: CGRect) {
        super.init(frame: frame)
        [label,buttonEnter,buttonSignUp, textFieldPassword, textFieldUserName, badMessageLabel, goodMessageLabel].forEach {
            self.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setlayout()
    }
    
    private func setlayout(){
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
            CenterY(-100)
        )
        textFieldUserName.easy.layout(
            Left(50),
            Top(20).to(badMessageLabel)
        )
        textFieldPassword.easy.layout(
            Left(50),
            Top(20).to(textFieldUserName)
        )
        buttonEnter.easy.layout(
            CenterX(),
            Top(20).to(textFieldPassword),
            Size(CGSize(width: 100, height: 50))
        )
        buttonSignUp.easy.layout(
            CenterX(),
            Bottom(20)
        )
    }
    @objc
    func enterButtonTapped(){
        let mail = textFieldUserName.text
        let password = textFieldPassword.text
        delegate?.enterButtonTapped(mail!, password!)
    }
    
    @objc
    func signUpButtonTapped(){
        delegate?.signUpButtonTapped()
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
