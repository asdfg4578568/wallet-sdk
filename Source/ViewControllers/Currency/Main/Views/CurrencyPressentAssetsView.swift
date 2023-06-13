//
//  CurrencyPressentAssetsView.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import UIKit
import SnapKit

class CurrencyPressentAssetsView: UIView {
   
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let assetsContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let assetsImageView = UIImageView()
    
//    private let assetsContainerStackView: UIStackView = {
//        let stackView = UIStackView()
//        return stackView
//    }()
    
//    private let assetsTitle: UILabel = {
//        let label = UILabel()
//        label.textColor = .wWhite
//        label.font = UIFont.font(name: .regular, and: 16)
//        label.isHidden = true
//        return label
//    }()
    
    private let assetsAmount: UILabel = {
        let label = UILabel()
        label.textColor = .wWhite
        label.font = UIFont.font(name: .bold, and: 24)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("currency_screen_buy".localized, for: .normal)
        button.setTitleColor(.wLightLightBlue, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 14)
        button.backgroundColor = .clear
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.setImage("refresh_home_screen_icon".imageByName, for: .normal)
        button.backgroundColor = .clear
        button.isHidden = true
        return button
    }()
    
    /*
    private let sendAndReceiveContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
   
    private let sendAssetsView: CircleButtonWithTitle = {
        let view = CircleButtonWithTitle(size: .size32, fontForLabel: UIFont.font(name: .semiBold, and: 14))
        return view
    }()
    
    private let receiveAssetsView: CircleButtonWithTitle = {
        let view = CircleButtonWithTitle(size: .size32, fontForLabel: UIFont.font(name: .semiBold, and: 14))
        return view
    }()
    */
    
    var didTapEyePressed: () -> Void = {}
    var didTapBuyPressed: () -> Void = {}
    var didTapRefreshPressed: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.addGradientLayer(with: [UIColor.wLightBlue.cgColor, UIColor.wLightBlue.withAlphaComponent(0.8).cgColor])
        containerView.corner(cornerRadius: 20)
        assetsContainerView.addGradientLayer(with: [UIColor.wSkyBlue.cgColor, UIColor.wSkyDarkBlue.withAlphaComponent(0.7).cgColor])
        assetsContainerView.corner(cornerRadius: 20, borderWidth: 2, borderColor: .wWhite)
        
        buyButton.backgroundColor = .wWhite
        buyButton.corner(cornerRadius: 4)
        buyButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    }
    
    func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [assetsContainerView])
        assetsContainerView.addSubviews(with: [assetsImageView, assetsAmount, eyeButton, buyButton, refreshButton])
        //sendAndReceiveContainerView.addSubviews(with: [sendAssetsView, receiveAssetsView])

//        assetsContainerStackView.axis = .vertical
//        assetsContainerStackView.alignment = .fill
//        assetsContainerStackView.distribution = .fill
//        assetsContainerStackView.addArrangedSubview(assetsTitle)
//        assetsContainerStackView.addArrangedSubview(assetsAmount)
        
        eyeButton.addTarget(self, action: #selector(eyePressed), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(buyPressed), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshPressed), for: .touchUpInside)

    }
    
    func setupConstraints() {
        
        snp.makeConstraints { make in
            make.height.equalTo(189)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        assetsContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-17)
            make.height.equalTo(130)
        }
        
//        assetsContainerStackView.snp.makeConstraints { make in
//            make.width.greaterThanOrEqualTo(50)
//            make.top.equalToSuperview().offset(17)
//            make.leading.equalToSuperview().offset(30)
//        }
        
        assetsAmount.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(30)
        }
        
        eyeButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(assetsAmount.snp.trailing).offset(5)
            make.centerY.equalTo(assetsAmount)
            make.width.equalTo(20)
            make.height.equalTo(15)
        }
        
        buyButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalTo(assetsAmount.snp.bottom).offset(5)
            make.height.equalTo(22)
            make.width.equalTo(58)

        }
        
        refreshButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-11)
            make.height.width.equalTo(22)
        }
        
        assetsImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(78)
            make.width.equalTo(104)
        }
        
        
        /*
        sendAndReceiveContainerView.snp.makeConstraints { make in
            make.top.equalTo(assetsContainerView.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-17)
        }
        
        sendAssetsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(-70)
            make.centerY.equalToSuperview()
            make.height.equalTo(CircleButtonWithTitle.CircleButtonSize.size32.rawValue)
        }
        
        receiveAssetsView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview().offset(70)
            make.centerY.equalToSuperview()
            make.height.equalTo(CircleButtonWithTitle.CircleButtonSize.size32.rawValue)
        }
         */
    }
    
    func setData(with fullAmount: String, and shouldHideData: Bool) {
        
        //sendAssetsView.setData(with: "Transfer", and: "up_right_arrow_icon", backgroundColor: .wWhite)
        //receiveAssetsView.setData(with: "Receive", and: "down_left_arrow_icon", backgroundColor: .wWhite)
        assetsImageView.image = "pressent_assets_all_crypto".imageByName
        //assetsTitle.text = "currency_pressent_assets".localized
        assetsAmount.text = shouldHideData ? "\(SDKManager.shared.currencySymbol.symbol)*******" : fullAmount
        let image = shouldHideData ? "showing_data_home_screen_icon".imageByName : "hidden_data_home_screen_icon".imageByName
        eyeButton.setImage(image, for: .normal)
    }
    
    @objc private func eyePressed() {
        didTapEyePressed()
    }
    
    @objc private func buyPressed() {
        didTapBuyPressed()
    }
    
    @objc private func refreshPressed() {
        didTapRefreshPressed()
    }
}

