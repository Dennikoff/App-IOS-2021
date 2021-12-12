//
//  TimeWithoutSmokingView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy


struct TimeWithoutSmokingModel {
    struct Days {
        let firstDigit: Int
        let secondDigit: Int
    }
    
    struct Hours {
        let firstDigit: Int
        let secondDigit: Int
    }
    
    struct Minutes {
        let firstDigit: Int
        let secondDigit: Int
    }
    
    let days: Days
    let hours: Hours
    let minutes: Minutes
}



final class TimeWithoutSmokingView: UIView {
    private let firstTimeElement = TimeElementView()
    
    private let secondTimeElement = TimeElementView()
    
    private let thirdTimeElement = TimeElementView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .white
        label.text = "Без сигарет уже:"
        return label
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "дней"
        return label
    }()
    
    private let hoursLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "часов"
        return label
    }()
    
    private let minLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.text = "минут"
        return label
    }()
    
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.4, alpha: 1)
        layer.cornerRadius = 12
        
        let allSubviews = [
            firstTimeElement,
            secondTimeElement,
            thirdTimeElement,
            titleLabel,
            daysLabel,
            hoursLabel,
            minLabel
        ]
        allSubviews.forEach {
            addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    // MARK: -Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    func configure(digits: (days: (Int, Int), hours: (Int, Int), minutes: (Int, Int))) {
        firstTimeElement.configure(with: digits.days)
        secondTimeElement.configure(with: digits.hours)
        thirdTimeElement.configure(with: digits.minutes)
    }
    
    func setLayout() {
        
        titleLabel.easy.layout(
            CenterX(),
            Top(12)
        )

        secondTimeElement.easy.layout(
            Size(CGSize(width: 70, height: 58)),
            Top(12).to(titleLabel),
            CenterX()
        )
        
        hoursLabel.easy.layout(
            CenterX().to(secondTimeElement),
            Top(15).to(secondTimeElement)
        )
        
        firstTimeElement.easy.layout(
            Size(CGSize(width: 70, height: 58)),
            CenterY().to(secondTimeElement),
            Right(18).to(secondTimeElement)
        )

        daysLabel.easy.layout(
            CenterX().to(firstTimeElement),
            Top(15).to(firstTimeElement)
        )

        thirdTimeElement.easy.layout(
            Size(CGSize(width: 70, height: 58)),
            CenterY().to(secondTimeElement),
            Left(18).to(secondTimeElement)
        )

        minLabel.easy.layout(
            CenterX().to(thirdTimeElement),
            Top(15).to(thirdTimeElement)
        )
    }
}
