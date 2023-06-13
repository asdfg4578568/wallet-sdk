//
//  PaymentInfoView.swift
//  WalletSDK
//
//  Created by ashahrouj on 29/12/2022.
//

import UIKit
import SnapKit

class PaymentInfoView: UIView {
   
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let containerStackViewView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private var arrayOfPaymentInfo: [PaymentInfoModel]
    private let currencyAssets: CurrencyAssetsEnum
    
    init(with arrayOfPaymentInfo: [PaymentInfoModel], currencyAssets: CurrencyAssetsEnum) {
        self.arrayOfPaymentInfo = arrayOfPaymentInfo
        self.currencyAssets = currencyAssets
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.backgroundColor = .wWhite
        containerView.corner()
        containerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(containerStackViewView)
        
        for (index,item) in arrayOfPaymentInfo.enumerated() {
            
            switch currencyAssets {
            case .trx, .usdtTrc20:
                containerStackViewView.distribution = .fill
                containerStackViewView.alignment = .fill
                containerStackViewView.spacing = 15
                
                if index == arrayOfPaymentInfo.count - 1  {
                    let bandWidthView = PaymentInfoBandWidthRowView(with: "transfer_if_bandwidth_resources_small_title".localized)
                    containerStackViewView.addArrangedSubview(bandWidthView)
                } else {
                    let infoRow = PaymentInfoRowView(with: item.iconName, titleInfo: item.titleInfo, subTitleInfo: item.subTitleInfo)
                    containerStackViewView.addArrangedSubview(infoRow)
                }
                
                
            default:
                
                containerStackViewView.distribution = .fillEqually
                containerStackViewView.alignment = .fill
                containerStackViewView.spacing = 5
                
                if let _ = item.secondSubTitleInfo  {
                    let infoRow = PaymentInfoMinerFeeRowView(with: item)
                    containerStackViewView.addArrangedSubview(infoRow)
                } else {
                    let infoRow = PaymentInfoRowView(with: item.iconName, titleInfo: item.titleInfo, subTitleInfo: item.subTitleInfo)
                    containerStackViewView.addArrangedSubview(infoRow)
                }
            }
        }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerStackViewView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-17)
        }
        
//        paymentInfoBandWidthRowView.snp.makeConstraints { make in
//            make.top.equalTo(containerStackViewView.snp.bottom).offset(17)
//            make.leading.equalToSuperview().offset(25)
//            make.trailing.equalToSuperview().offset(-25)
//            make.bottom.equalToSuperview().offset(-17)
//        }
    }
}
