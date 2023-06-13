//
//  CurrencyAssetCardView.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import UIKit

struct CurrencyAssetCardModel {
    let mainColor: UIColor
    let cardColor: UIColor
    let assetName: String
    let assetIconBackgroundColor: UIColor
    let assetIconName: String
    var assetAmount: String
}

class CurrencyAssetCardView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.font(name: .bold, and: 16)
        label.textColor = .wWhite
        return label
    }()
    
    private let assetButton: CircleButtonWithTitle = {
        let circleButton = CircleButtonWithTitle(size: .size40, fontForLabel: .font(name: .semiBold, and: 16), titleColor: .wWhite)
        return circleButton
    }()
    
    let refreshButton: CircleButton = {
        let circleButton = CircleButton()
        circleButton.setData(with: .clear, and: "refresh_white_icon")
        return circleButton
    }()
    
    private var currencyAssetCardModel: CurrencyAssetCardModel
    private var shouldDisplayRefreshButton: Bool
    init(with currencyAssetCardModel: CurrencyAssetCardModel, shouldDisplayRefreshButton: Bool = false) {
        self.currencyAssetCardModel = currencyAssetCardModel
        self.shouldDisplayRefreshButton = shouldDisplayRefreshButton
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setData()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.corner()
    }
    
    func setupViews() {
        backgroundColor = currencyAssetCardModel.mainColor
        containerView.backgroundColor = currencyAssetCardModel.cardColor
        addSubview(containerView)
        containerView.addSubviews(with: [amountLabel, assetButton])
        
        if shouldDisplayRefreshButton {
            containerView.addSubview(refreshButton)
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(22)
            make.leading.equalTo(22)
            make.trailing.equalTo(-22)
            make.bottom.equalTo(-22)
        }
        
        assetButton.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(CircleButtonWithTitle.CircleButtonSize.size40.rawValue)
        }
        
        if shouldDisplayRefreshButton {
            amountLabel.snp.makeConstraints { make in
                make.leading.equalTo(assetButton.snp.trailing).offset(15)
                make.centerY.equalToSuperview()
            }
            
            refreshButton.snp.makeConstraints { make in
                make.leading.equalTo(amountLabel.snp.trailing).offset(5)
                make.centerY.equalTo(amountLabel)
                make.trailing.equalTo(-15)
                make.height.width.equalTo(20)
            }
            
        } else {
            amountLabel.snp.makeConstraints { make in
                make.leading.equalTo(assetButton.snp.trailing).offset(15)
                make.trailing.equalTo(-15)
                make.centerY.equalToSuperview()
            }
        }
    }

    func setData() {
        refreshButton.isHidden = !shouldDisplayRefreshButton
        assetButton.setData(with: currencyAssetCardModel.assetName, and: currencyAssetCardModel.assetIconName, backgroundColor: currencyAssetCardModel.assetIconBackgroundColor)
        amountLabel.text = currencyAssetCardModel.assetAmount
    }
    
    func setAsset(for amount: String) {
        currencyAssetCardModel.assetAmount = amount
        amountLabel.text = currencyAssetCardModel.assetAmount
    }
}
