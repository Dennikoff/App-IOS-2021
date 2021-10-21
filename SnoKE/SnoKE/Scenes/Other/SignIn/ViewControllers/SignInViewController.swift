//
//  SignInViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy

class SignInViewController: UIViewController {
    
    private let buttonEnter: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.set(.darkGray, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.isHidden = false
        return button
    }()
    
    private let buttonSignUp: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        //button.set(.darkGray, for: .normal)
        button.backgroundColor = .none
        button.isHidden = false
        return button
    }()
    
    private let label:UILabel = {
        let label = UILabel()
        label.text = "Кто вы?\nНемедленно\nназовитесь"
        label.numberOfLines = 0
        label.layer.cornerRadius = 12
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize:50)
        return label
    }()
    
    private let TextFieldUserName: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Почта"
        //let txt = UITextField(frame: CGRect(origin: CGPoint(x: 10, y:20), size:CGSize(width: 40, height: 10)), primaryAction: nil)
        return txt
    }()
    
    private let TextFieldPassword: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Пароль"
        //let txt = UITextField(frame: CGRect(origin: CGPoint(x: 10, y:20), size:CGSize(width: 40, height: 10)), primaryAction: nil)
        return txt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        [buttonEnter, label, TextFieldUserName,TextFieldPassword,buttonSignUp].forEach{
            view.addSubview($0)}
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setlayout()
    }

    private func setlayout(){
        label.easy.layout(
            CenterX(-30),
            CenterY(-100)
        )
        TextFieldUserName.easy.layout(
            Left(50),
            Top(20).to(label)
        )
        TextFieldPassword.easy.layout(
            Left(50),
            Top(20).to(TextFieldUserName)
        )
        buttonEnter.easy.layout(
            CenterX(),
            Top(20).to(TextFieldPassword),
            Size(CGSize(width: 100, height: 50))
        )
        buttonSignUp.easy.layout(
            CenterX(),
            Bottom(20)
        )
    }
}
