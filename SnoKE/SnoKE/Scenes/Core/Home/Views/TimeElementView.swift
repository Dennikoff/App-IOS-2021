//
//  TimeElementView.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import EasyPeasy

final class TimeElementView: UIView {
    
    // MARK: -Properties
    private let firstTopBlock: UIView = {
        let block = UIView()
        block.layer.cornerRadius = 10
        block.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        return block
    }()
    
    private let firstBottomBlock: UIView = {
        let block = UIView()
        block.layer.cornerRadius = 10
        block.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return block
    }()
    
    private let secondTopBlock: UIView = {
        let block = UIView()
        block.layer.cornerRadius = 10
        block.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return block
    }()
    
    private let secondBottomBlock: UIView = {
        let block = UIView()
        block.layer.cornerRadius = 10
        block.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return block
    }()
    
    private let firstDigit: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    private let secondDigit: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .semibold)
        return label
    }()
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let allSubviews = [
            firstTopBlock,
            firstBottomBlock,
            secondTopBlock,
            secondBottomBlock,
            firstDigit,
            secondDigit
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
        
        let blocksColor = #colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.7098039216, alpha: 1)
        let blocks = [firstTopBlock, firstBottomBlock, secondTopBlock, secondBottomBlock]
        blocks.forEach {
            $0.backgroundColor = blocksColor
        }
    }
    
    func configure(with digits: (first: Int, second: Int)) {
        firstDigit.text = String(digits.first)
        secondDigit.text = String(digits.second)
    }
    
    func setLayout() {
        [firstTopBlock, firstBottomBlock, secondTopBlock, secondBottomBlock].forEach {
            $0.easy.layout(
                Size(CGSize(width: 33, height: 28))
            )
        }
        firstTopBlock.easy.layout(
            Left(),
            Top()
        )
        
        firstBottomBlock.easy.layout(
            Left(),
            Top(2).to(firstTopBlock)
        )
        
        secondTopBlock.easy.layout(
            CenterY().to(firstTopBlock),
            Left(4).to(firstTopBlock)
        )
        
        secondBottomBlock.easy.layout(
            CenterY().to(firstBottomBlock),
            CenterX().to(secondTopBlock)
        )
        
        firstDigit.easy.layout(
            CenterX().to(firstTopBlock),
            Top(14)
        )
        secondDigit.easy.layout(
            CenterX().to(secondTopBlock),
            Top(14)
        )

    }
    
    
}
