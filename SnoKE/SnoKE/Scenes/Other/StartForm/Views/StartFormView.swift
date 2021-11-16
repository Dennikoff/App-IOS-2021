//
//  HzView.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit
import EasyPeasy
import TextFieldEffects

protocol StartFormViewDelegate: AnyObject {
    func enterButtonTapped()
    func showNotAllFilledAlert()
}

class StartFormView: UIView {
    
    weak var delegate: StartFormViewDelegate?
    
    private let cigaretteImage: UIImageView = {
        $0.image = UIImage(named: "cigarette broken")
        $0.alpha = 0.3
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let enterButton: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .accentColor
        $0.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let numberSmokedLabel: UILabel = {
        $0.text = "Сколько сигарет в день Вы курили?"
        $0.textColor = .accentColor
        return $0
    }(UILabel())
    
    private let priceLabel: UILabel = {
        $0.text = "Сколько рублей стоила пачка?"
        $0.textColor = .accentColor
        return $0
    }(UILabel())
    
    private let numberInPackLabel: UILabel = {
        $0.text = "Сколько сигарет было в пачке?"
        $0.textColor = .accentColor
        return $0
    }(UILabel())
    
    private let numberSmokedContainer:UIView = {
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 1
        return $0
    }(UIView())
    
    private let priceContainer: UIView = {
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 1
        return $0
    }(UIView())
    
    private let numberInPackContainer: UIView = {
        $0.layer.cornerRadius = 13
        $0.layer.borderWidth = 1
        return $0
    }(UIView())
    
    private let numberSmokedTextField: UITextField = {
        $0.placeholder = "Кол-во сигарет"
        $0.keyboardType = .numberPad
        $0.addDoneCancelToolbar()
        return $0
    }(UITextField())
    
    private let priceTextField: UITextField = {
        $0.placeholder = "RUB"
        $0.keyboardType = .numberPad
        $0.addDoneCancelToolbar()
        return $0
    }(UITextField())
    
    private let numberInPackTextField: UITextField = {
        $0.placeholder = "Кол-во сигарет"
        $0.keyboardType = .numberPad
        return $0
    }(UITextField())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        numberSmokedContainer.addSubview(numberSmokedTextField)
        priceContainer.addSubview(priceTextField)
        numberInPackContainer.addSubview(numberInPackTextField)
        [cigaretteImage,
         numberSmokedLabel,
         priceLabel,
         numberInPackLabel,
         numberSmokedContainer,
         priceContainer,
         numberInPackContainer,
         enterButton].forEach{
            self.addSubview($0)
        }
        
        priceTextField.addDoneCancelToolbar(onDone: nil,
                                       onCancel: (target: self,
                                                  action: #selector(priceTextKeyboardButtonTapped)))
        
        numberInPackTextField.addDoneCancelToolbar(onDone: nil,
                                              onCancel: (target: self,
                                                         action: #selector(numberInPackTextKeyboardButtonTapped)))
        
        numberSmokedTextField.addDoneCancelToolbar(onDone: nil,
                                              onCancel: (target: self,
                                                         action: #selector(numberSmokedTextKeyboardButtonTapped)))
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    @objc private func numberInPackTextKeyboardButtonTapped() {
        numberInPackTextField.text = ""
        numberInPackTextField.resignFirstResponder()
    }
    
    @objc private func priceTextKeyboardButtonTapped() {
        priceTextField.text = ""
        priceTextField.resignFirstResponder()
    }
    
    @objc private func numberSmokedTextKeyboardButtonTapped() {
        numberSmokedTextField.text = ""
        numberSmokedTextField.resignFirstResponder()
    }
    
    @objc private func enterButtonTapped() {
        guard let numberSmokedText = numberSmokedTextField.text,
              let numberInPackText = numberInPackTextField.text,
              let priceText = priceTextField.text else {
            return
        }
        if numberSmokedText.isEmpty || numberInPackText.isEmpty || priceText.isEmpty {
            delegate?.showNotAllFilledAlert()
        } else {
            delegate?.enterButtonTapped()
        }
        
    }
    
    private func setLayout(){
        cigaretteImage.easy.layout(
            Size(CGSize(width: 170, height: 170)),
            Bottom(40).to(enterButton),
            CenterX(50)
        )
        
        numberSmokedLabel.easy.layout(
            Top(200),
            Left(30)
        )
        
        numberSmokedContainer.easy.layout(
            Top(5).to(numberSmokedLabel),
            Left(30),
            Right(30),
            Height(40)
        )
        
        priceLabel.easy.layout(
            Top(40).to(numberSmokedContainer),
            Left(30)
        )
        
        priceContainer.easy.layout(
            Top(5).to(priceLabel),
            Left(30),
            Right(30),
            Height(40)
        )
        
        numberInPackLabel.easy.layout(
            Top(40).to(priceContainer),
            Left(30)
        )
        
        numberInPackContainer.easy.layout(
            Top(5).to(numberInPackLabel),
            Left(30),
            Right(30),
            Height(40)
        )
        
        enterButton.easy.layout(
            Bottom((UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? .zero)+20),
            Size(CGSize(width: 300, height: 45)),
            CenterX()
        )
        
        [numberSmokedTextField,priceTextField,numberInPackTextField].forEach{
            $0.easy.layout(
                Left(10),
                Right(10),
                CenterY()
            )
        }
    }
}
