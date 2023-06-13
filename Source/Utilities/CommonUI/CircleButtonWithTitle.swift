//
//  CircleButtonWithTitle.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/12/2022.
//

import UIKit
import SnapKit

class CircleButtonWithTitle: UIView {

    enum CircleButtonSize: Int {
        case size32 = 32
        case size40 = 40
        case size42 = 42
        case size50 = 50
    }
    
    let circleButton: CircleButton = {
        let button = CircleButton()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
        
    private var size: CircleButtonSize = .size32
    
    init(size: CircleButtonSize, fontForLabel: UIFont, titleColor: UIColor = .wWLightBlack) {
        super.init(frame: .zero)
        setupViews(with: fontForLabel, titleColor: titleColor)
        setupConstraints(with: size)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(with fontForLabel: UIFont, titleColor: UIColor) {
        backgroundColor = .clear
        addSubviews(with: [circleButton, titleLabel])
        titleLabel.font = fontForLabel
        titleLabel.textColor = titleColor
    }
    
    func setupConstraints(with size: CircleButtonSize) {
        circleButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(size.rawValue)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleButton.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setData(with text: String, and imageName: String, backgroundColor: UIColor) {
        titleLabel.text = text
        if !imageName.isEmpty {
            circleButton.setData(with: backgroundColor, and: imageName)
        }
    }

}
