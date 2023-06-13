//
//  CurrencyAssetsCotainerView.swift
//  WalletSDK
//
//  Created by ashahrouj on 08/12/2022.
//

import UIKit
import SnapKit

class CurrencyAssetsCotainerView: UIView {

    private let containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "currency_assets_title".localized
        label.font = UIFont.font(name: .semiBold, and: 20)
        label.textColor = .wWLightBlack
        return label
     }()

    private let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -27
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func setupViews() {
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, stackContainerView])
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(27)
            make.trailing.equalTo(45)
            make.height.equalTo(30)
        }
        
        stackContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func setData(with data: [CurrencyModel], and shouldHideData: Bool) {
        
        stackContainerView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for item in data {
            let view = CurrencyAssetsView(with: item, and: shouldHideData)
            stackContainerView.addArrangedSubview(view)
        }
        
        let currencyModel = CurrencyModel(coinType: 100, name: "", description: "")
        let view = CurrencyAssetsView(with: currencyModel, and: true)
        stackContainerView.addArrangedSubview(view)
    }
}
