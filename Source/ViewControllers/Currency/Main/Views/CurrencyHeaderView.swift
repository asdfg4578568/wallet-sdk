//
//  CurrencyHeaderView.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import Foundation
import UIKit
import SnapKit

class CurrencyHeaderView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let currencyButton: CircleButtonWithTitle = {
        let button = CircleButtonWithTitle(size: .size32, fontForLabel: UIFont.font(name: .semiBold, and: 16))
        return button
    }()
    
    private let arrowButton: CircleButton = {
        let button = CircleButton()
        return button
    }()
    
    private let verticalLineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .blue
        return lineView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byTruncatingMiddle
        label.font = UIFont.font(name: .regular, and: 12)
        return label
    }()
    
    private let copyAddressButton: CircleButton = {
        let button = CircleButton()
        button.backgroundColor = .wBlue
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        containerView.addGradientLayer(with: [UIColor.wMidLightGray.cgColor, UIColor.wWhite.cgColor])
        containerView.corner(borderWidth: 2, borderColor: .wWhite)
        containerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: true)
    }
    
    func setupViews() {
        backgroundColor = .clear
        containerView.backgroundColor = UIColor.wMidLightGray
        addSubview(containerView)
        containerView.addSubviews(with: [currencyButton, arrowButton, verticalLineView, addressLabel, copyAddressButton])
        
        arrowButton.pressed = {
            print("arrow pressed")
        }
        
        copyAddressButton.pressed = {
            print("copy address pressed")
        }
    }
    
    func setupConstraints() {
        
        snp.makeConstraints { make in
            make.height.equalTo(75)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-18)
        }
        
        currencyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.height.equalTo(CircleButtonWithTitle.CircleButtonSize.size32.rawValue)
            //make.width.equalTo(75)
            make.centerY.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints { make in
            make.leading.equalTo(currencyButton.snp.trailing).offset(10)
            make.height.width.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        verticalLineView.snp.makeConstraints { make in
            make.leading.equalTo(arrowButton.snp.trailing).offset(10)
            make.width.equalTo(0.3)
            make.height.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        addressLabel.snp.makeConstraints { make in
            make.leading.equalTo(verticalLineView.snp.trailing).offset(10)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
        }
        
        copyAddressButton.snp.makeConstraints { make in
            make.leading.equalTo(addressLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.width.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
    
    func setData() {
        copyAddressButton.setData(with: .wWhite, and: "copy_address_icon")
        arrowButton.setData(with: .wWhite, and: "down_arrow_icon")
        currencyButton.setData(with: "ETH", and: "asset_eth_icon", backgroundColor: .wDarkPurpl)
        addressLabel.text = "Bc1qxy2iuashjasd23csder231kjashdq2n0yrf"
    }
}
