//
//  DiaryToggleView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 12.12.2021.
//

import UIKit

protocol DiaryToggleViewDelegate: AnyObject {
    func diaryToggleViewDidTapAchievements(_ toggleView: DiaryToggleView)
    func diaryToggleViewDidTapEmotions(_ toggleView: DiaryToggleView)
}

class DiaryToggleView: UIView {
    
    // MARK: - Properties
    weak var delegate: DiaryToggleViewDelegate?
    
    private let achievementsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.accentColor, for: .normal)
        button.setTitle("Достижения", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    private let emotionsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.accentColor, for: .normal)
        button.setTitle("Состояние", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    private let indicatorView: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = .accentColor
        indicator.layer.masksToBounds = true
        indicator.layer.cornerRadius = 2
        return indicator
    }()
    
    enum State {
        case achievements
        case emotions
    }
    
    var state: State = .achievements
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(achievementsButton)
        addSubview(emotionsButton)
        addSubview(indicatorView)
        achievementsButton.addTarget(self, action: #selector(didTapAchievements), for: .touchUpInside)
        emotionsButton.addTarget(self, action: #selector(didTapEmotions), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    @objc private func didTapAchievements() {
        state = .achievements
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorPosition()
        }
        delegate?.diaryToggleViewDidTapAchievements(self)
    }
    
    @objc private func didTapEmotions() {
        state = .emotions
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorPosition()
        }
        delegate?.diaryToggleViewDidTapEmotions(self)
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorPosition()
        }
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        achievementsButton.translatesAutoresizingMaskIntoConstraints = false
        achievementsButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        achievementsButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        achievementsButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        achievementsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
        emotionsButton.translatesAutoresizingMaskIntoConstraints = false
        emotionsButton.leftAnchor.constraint(equalTo: achievementsButton.rightAnchor).isActive = true
        emotionsButton.centerYAnchor.constraint(equalTo: achievementsButton.centerYAnchor).isActive = true
        emotionsButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        emotionsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicatorView.topAnchor.constraint(equalTo: emotionsButton.bottomAnchor).isActive = true
        updateIndicatorPosition()
    }
    
    private func updateIndicatorPosition() {
        switch state {
        case .achievements:
            indicatorView.frame = CGRect(x: 10, y: achievementsButton.bottom, width: 100, height: 4)
        case .emotions:
            indicatorView.frame = CGRect(x: 130, y: achievementsButton.bottom, width: 100, height: 4)
        }
    }
}
