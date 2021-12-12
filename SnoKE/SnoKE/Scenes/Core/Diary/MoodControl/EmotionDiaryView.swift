//
//  EmotionDiaryView.swift
//  SnoKE
//
//  Created by Kristina Shlyapkina on 18.11.2021.
//

import SwiftUI
import EasyPeasy

final class EmotionDiaryView: UIView {
    
    // MARK: - Properties
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.text = "Как вы себя чувствуете?"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stickerAngry: EmojiView = {
        let sticker = EmojiView()
        sticker.delegate = self
        sticker.type = .angry
        return sticker
    }()
    
    private lazy var stickerUpset: EmojiView = {
        let sticker = EmojiView()
        sticker.delegate = self
        sticker.type = .upset
        return sticker
    }()
    
    private lazy var stickerNormal: EmojiView = {
        let sticker = EmojiView()
        sticker.delegate = self
        sticker.type = .normal
        return sticker
    }()
    
    private lazy var stickerHappy: EmojiView = {
        let sticker = EmojiView()
        sticker.delegate = self
        sticker.type = .happy
        return sticker
    }()
    
    private lazy var emotionArray = [stickerAngry, stickerUpset, stickerNormal, stickerHappy]
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: emotionArray)
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 35.54
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var notes: UIView = {
        let notes = UIView()
        notes.layer.cornerRadius = 10
        notes.layer.borderColor = UIColor(red: 176/255, green: 180/255, blue: 186/255, alpha: 1).cgColor
        notes.layer.borderWidth = 1
        return notes
    }()
    
    private let notesLabel: UILabel = {
        let notesLabel = UILabel()
        notesLabel.text = "  Заметки  "
        notesLabel.backgroundColor = .white
        return notesLabel
    }()
    
    private let notesTextField: UITextView = {
        let notesTextTwo = UITextView()
        notesTextTwo.text = "Расскажите подробнее, если хотите :)"
        notesTextTwo.font = .systemFont(ofSize: 13)
        notesTextTwo.textColor = UIColor.lightGray
        notesTextTwo.autocapitalizationType = .none
        return notesTextTwo
    }()
    
    private let confidenceLabel: UILabel = {
        let confidenceLabel = UILabel()
        confidenceLabel.font = .systemFont(ofSize: 17, weight: .bold)
        confidenceLabel.numberOfLines = 0
        confidenceLabel.adjustsFontSizeToFitWidth = true
        confidenceLabel.text = "Моя уверенность, что я не сорвусь"
        confidenceLabel.translatesAutoresizingMaskIntoConstraints = false
        return confidenceLabel
    }()
    
    private let sliderMood: UISlider = {
        let slider = UISlider()
        slider.value = 2
        slider.minimumValue = 0
        slider.maximumValue = 3
        return slider
    }()
    
    private var moodView: UIImageView = {
        var moodView = UIImageView()
        moodView.contentMode = .scaleAspectFit
        moodView.image = UIImage(named: "moodNormal")
        return moodView
    }()
    
    private let doneButton: UIButton = {
        let doneButton = UIButton()
        doneButton.setTitle("Подтвердить", for: .normal)
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        doneButton.backgroundColor = .accentColor
        doneButton.layer.cornerRadius = 10
        return doneButton
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func sliderChanged() {
        let value = sliderMood.value.rounded()
        sliderMood.value = value
        
        switch Int(value) {
        case 0:
            moodView.image = UIImage(named: "moodUpset")
        case 1:
            moodView.image = UIImage(named: "moodNormal")
        case 2:
            moodView.image = UIImage(named: "moodHappy")
        case 3:
            moodView.image = UIImage(named: "moodVeryHappy")
        default:
            break
        }
    }
    
    // MARK: -Methods
    func setupView() {
        notesTextField.delegate = self
        sliderMood.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        addSubview(welcomeLabel)
        welcomeLabel.easy.layout(
            Left(16),
            Height(41),
            Width(210),
            Top((UIApplication.shared.windows.first?.safeAreaInsets.top ?? .zero) + 45)
        )
        
        addSubview(stackView)
        stackView.easy.layout(
            Left(16),
            Height(110),
            Width(345),
            Top(16).to(welcomeLabel)
        )
        
        addSubview(notes)
        notes.easy.layout(
            Left(16),
            Right(16),
            Height(113),
            Top(25).to(stackView)
        )
        
        addSubview(notesLabel)
        notesLabel.easy.layout(
            Left(70),
            Top(15).to(stackView)
        )
        
        notes.addSubview(notesTextField)
        notesTextField.easy.layout(
            Left(16),
            Right(16),
            Top(16),
            Bottom(16)
        )
        
        addSubview(confidenceLabel)
        confidenceLabel.easy.layout(
            Left(16),
            Height(41),
            Width(308),
            Top(20).to(notes)
        )
        
        addSubview(sliderMood)
        sliderMood.easy.layout(
            Left(29),
            Right(29),
            Top(17).to(confidenceLabel)
        )
        
        addSubview(moodView)
        moodView.easy.layout(
            Center(),
            Top(20).to(sliderMood),
            Height(80)
        )
        
        addSubview(doneButton)
        doneButton.easy.layout(
            CenterX(),
            Right(25),
            Height(60),
            Top(50).to(moodView)
        )
    }
}

extension EmotionDiaryView: EmojiViewDelegate {
    func emojiPressed(type: EmojiView.EmpjiType) {
        emotionArray.forEach { $0.deselect() }
        emotionArray.first { $0.type == type }?.select()
    }
}

extension EmotionDiaryView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Расскажите подробнее, если хотите :)"
            textView.textColor = UIColor.lightGray
        }
    }
}

struct EmotionDiaryView_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        ViewPreview {
            EmotionDiaryView()
        }
    }
}
