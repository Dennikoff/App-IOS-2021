//
//  EmojiView.swift
//  SnoKE
//
//  Created by Kristina Shlyapkina on 23.11.2021.
//

import SwiftUI

protocol EmojiViewDelegate: AnyObject {
    func emojiPressed(type: EmojiView.EmpjiType)
}

final class EmojiView: UIView {
    
    weak var delegate: EmojiViewDelegate?
    
    enum EmpjiType {
        case angry, upset, normal, happy
        
        var image: UIImage {
            switch self {
            case .angry: return UIImage(named: "emojiAngry")!
            case .upset: return UIImage(named: "emojiUpset")!
            case .normal: return UIImage(named: "emojiNormal")!
            case .happy: return UIImage(named: "emojiHappy")!
            }
        }
    }
    
    var type: EmojiView.EmpjiType = .happy {
        didSet {
            fullImage.image = type.image
        }
    }
    
    private lazy var fullImage: UIImageView = {
        let emojis = UIImageView()
        emojis.image = type.image
        emojis.contentMode = .center
        emojis.translatesAutoresizingMaskIntoConstraints = false
        return emojis
    }()
    
    private lazy var smallImage: UIImageView = {
        let checkEmoji = UIImageView()
        checkEmoji.image = UIImage(named: "checkEmoji")
        checkEmoji.isHidden = true
        checkEmoji.translatesAutoresizingMaskIntoConstraints = false
        return checkEmoji
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    convenience init(type: EmojiView.EmpjiType, selected: Bool) {
        self.init(frame: .zero)
        self.fullImage.image = type.image
        smallImage.isHidden = !selected
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        button.addTarget(self, action: #selector(selectPressed), for: .touchUpInside)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func selectPressed() {
        delegate?.emojiPressed(type: type)
    }
    
    func deselect() {
        smallImage.isHidden = true
    }
    
    func select() {
        smallImage.isHidden = false
    }
    
    // MARK: -Methods
    func setupConstraints() {
        [fullImage, smallImage, button].forEach {
            addSubview($0)
        }
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        fullImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fullImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        fullImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        fullImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        heightAnchor.constraint(equalToConstant: 58.46).isActive = true
        widthAnchor.constraint(equalToConstant: 58.46).isActive = true
        
        smallImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        smallImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6.8).isActive = true
        smallImage.heightAnchor.constraint(equalToConstant: 13.6).isActive = true
        smallImage.widthAnchor.constraint(equalToConstant: 13.6).isActive = true
    }
}


struct EmojiView_Preview: PreviewProvider {
    static var previews: some SwiftUI.View {
        ViewPreview {
            EmojiView()
        }
    }
}
