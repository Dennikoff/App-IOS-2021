//
//  HzView.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit
import EasyPeasy
import TextFieldEffects

class HzView: UIView {

    private let numberSmokedText:   HoshiTextField = {
        $0.placeholder = "Сколько сигарет в день вы курили?"
        $0.placeholderFontScale = 1.2
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = .gray
        $0.keyboardType = .numberPad
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
    private let priceText: HoshiTextField = {
        $0.placeholder = "Сколько рублей стоила одна пачка?"
        $0.placeholderFontScale = 1.2
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = .gray
        $0.keyboardType = .numberPad
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
    private let numberInPackText: HoshiTextField = {
        $0.placeholder = "Сколько сигарет было в пачке?"
        $0.placeholderFontScale = 1.2
        $0.borderActiveColor = UIColor(red: 254/255, green: 203/255, blue: 146/255, alpha: 1)
        $0.borderInactiveColor = .gray
        $0.keyboardType = .numberPad
        $0.autocapitalizationType = .none
        return $0
    }(HoshiTextField())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [priceText,
         numberSmokedText,
         numberInPackText].forEach{
            self.addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    private func setLayout(){
        numberSmokedText.easy.layout(
            Top(200),
            Left(50),
            Height(50)
        )
        priceText.easy.layout(
            Top(80).to(numberSmokedText),
            Left(50),
            Height(50)
        )
        numberInPackText.easy.layout(
            Top(80).to(priceText),
            Left(50),
            Height(50)
        )
    }
}
