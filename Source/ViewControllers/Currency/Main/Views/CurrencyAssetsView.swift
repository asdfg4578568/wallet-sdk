//
//  CurrencyAssetsView.swift
//  WalletSDK
//
//  Created by ashahrouj on 08/12/2022.
//

import UIKit
import SnapKit

class CurrencyAssetsView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let buttonWithTitle: CircleButtonWithTitle = {
        let view = CircleButtonWithTitle(size: .size50, fontForLabel: UIFont.font(name: .semiBold, and: 20))
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 1
        stackView.axis = .vertical
        return stackView
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        label.textAlignment = .right
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.font(name: .regular, and: 14)
        label.textColor = UIColor.wDarkGray
        label.textAlignment = .right
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private var currencyModel: CurrencyModel
    private var shouldHideData: Bool
    
    init(with currencyModel: CurrencyModel, and shouldHideData: Bool) {
        self.currencyModel = currencyModel
        self.shouldHideData = shouldHideData
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setData(with: currencyModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        addBorders(withEdges: [.top])
        containerView.addBorders(withEdges: [.top])
    }

    func setupViews() {
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [buttonWithTitle, containerStackView, button])
        containerStackView.addArrangedSubview(amountLabel)
        containerStackView.addArrangedSubview(priceLabel)
        button.addTarget(self, action: #selector(currencyAssetPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(110)
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        buttonWithTitle.snp.makeConstraints { make in
            make.top.equalTo(22)
            make.leading.equalTo(30)
            make.height.equalTo(CircleButtonWithTitle.CircleButtonSize.size50.rawValue)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.equalTo(buttonWithTitle.snp.trailing).offset(15)
            make.centerY.equalTo(buttonWithTitle)
            make.trailing.equalToSuperview().offset(-45)
        }
    }
    
    private func setData(with currencyModel: CurrencyModel) {
        self.backgroundColor = currencyModel.asset.homeBackgroundColor
        buttonWithTitle.setData(with: currencyModel.asset.name, and: currencyModel.asset.iconNameWithBorder, backgroundColor: currencyModel.asset.homeBackgroundColor)
        
        switch currencyModel.asset {
        case .empty:
            amountLabel.text = ""
            priceLabel.text = ""
        default:
            amountLabel.text = shouldHideData ? "*********" : currencyModel.amount
            priceLabel.text = shouldHideData ? "≈\(SDKManager.shared.currencySymbol.symbol)*****" : currencyModel.ratioBalanceForDisplay
        }
        
    }
    
    @objc private func currencyAssetPressed() {
        NotificationCenter.default.post(name: .currencyAssetPressed, object: currencyModel)
    }
}
