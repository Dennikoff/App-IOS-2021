//
//  ViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 30.10.2021.
//

import UIKit

import UIKit
import EasyPeasy

struct TipModel {
    let title: String
    let text: String
}

final class TipView: UIView {
    private lazy var indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .accentColor
        view.layer.cornerRadius = 5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    
    private lazy var textLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TipModel) {
        titleLabel.text = model.title
        textLabel.text = model.text
    }
    
    private func setupViews() {
        [indicator, titleLabel, textLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setupLayout() {
        indicator.easy.layout(
            Top(16),
            Bottom(16),
            Width(5),
            Left(16)
        )
        titleLabel.easy.layout(
            Left(10).to(indicator),
            Top(16)
        )
        textLabel.easy.layout(
            Left(10).to(indicator),
            Width(350),
            Top(16).to(titleLabel)
        )
    }
}

final class UserWantsToSmokeViewController: UIViewController {
    private let tips: [TipModel] = [
        TipModel(title: "На улице", text: "Сходи на улицу и попробуй поймать лягушку, потом наряди ее в мини свадебное платье и выложи фотографию в инстаграм"),
        TipModel(title: "Дома", text: "Набери ванну, как в детстве - с пенкой! А потом устраивай цунами!"),
        TipModel(title: "С друзьями", text: "Уверен, что хоть 1 друг то у тебя есть! Позвони ему и спроси зачем он звонит в такое время, типа ты занят"),
        TipModel(title: "Другое", text: "Придумай что можно коллекционировать!"),
    ]
    
    private lazy var tipStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let tipView1 = TipView()
    let tipView2 = TipView()
    let tipView3 = TipView()
    let tipView4 = TipView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tipStackView)
        let tipViews = [tipView1, tipView2, tipView3, tipView4]
        for i in tipViews.indices {
            tipViews[i].configure(with: tips[i])
        }
        tipViews.forEach {
            tipStackView.addArrangedSubview($0)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        tipStackView.frame = view.bounds
//        setupLayout()
    }
    
    private func setupLayout() {
        [tipView1, tipView2, tipView3, tipView4].forEach {
            $0.easy.layout(
                Height(150)
            )
        }
    }
    
}
