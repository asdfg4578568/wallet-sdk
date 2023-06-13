//
//  CurrencyReceiveAndBandwidthView.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import UIKit
import SnapKit

class CurrencyReceiveAndBandwidthView: UIView {

    private let stackContainerView: UIStackView = {
       let view = UIStackView()
        return view
    }()
    
    // Receive view
    private let receiveContainerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let receiveContainerButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    private let receiveImageView: UIImageView = UIImageView()
    private let receiveTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 14)
        return label
    }()
    
    private let receiveDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 14)
        label.textAlignment = .right
        return label
    }()

    // Bandwidth views
    /*
    private let bandwidthContainerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let bandwidthView: TitleAndSubtitleView = TitleAndSubtitleView(forTitle: UIFont.font(name: .regular, and: 14),
                                                                           forSubtitle: UIFont.font(name: .bold, and: 14))
    private let energyView: TitleAndSubtitleView = TitleAndSubtitleView(forTitle: UIFont.font(name: .regular, and: 14),
                                                                        forSubtitle: UIFont.font(name: .bold, and: 14))
     */
    
    var recentPressed: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        receiveContainerView.addGradientLayer(with: [UIColor.wMidLightGray.cgColor, UIColor.wWhite.cgColor])
        receiveContainerView.corner(borderWidth: 2, borderColor: .wWhite)
        receiveContainerView.dropShadow(with: UIColor.wWLightDarkGray.cgColor, onlyBottom: true)
        
        //bandwidthContainerView.addGradientLayer(with: [UIColor.wMidLightGray.cgColor, UIColor.wWhite.cgColor])
        //bandwidthContainerView.corner(borderWidth: 2, borderColor: .wWhite)
        //bandwidthContainerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: true)
    }
    
    func setupViews() {
        
        backgroundColor = .clear
        addSubview(stackContainerView)
        receiveContainerView.addSubviews(with: [receiveImageView, receiveTitleLabel, receiveDateLabel, receiveContainerButton])
        receiveContainerView.backgroundColor = UIColor.wMidLightGray
        //bandwidthContainerView.backgroundColor = UIColor.wMidLightGray
        //bandwidthContainerView.addSubviews(with: [bandwidthView, energyView])

        stackContainerView.axis = .vertical
        stackContainerView.distribution = .equalSpacing
        stackContainerView.spacing = 24
        stackContainerView.backgroundColor = .clear
        
        stackContainerView.addArrangedSubview(receiveContainerView)
        //stackContainerView.addArrangedSubview(bandwidthContainerView)
        
        receiveContainerButton.addTarget(self, action: #selector(openRecentRecordsPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        stackContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        receiveContainerView.snp.makeConstraints { make in
            make.height.equalTo(61)
        }
        
        receiveContainerButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        receiveImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(13)
        }
        
        receiveTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(receiveImageView.snp.trailing).offset(5)
            make.centerY.equalToSuperview()
        }
        
        receiveDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(receiveTitleLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-21)
            make.centerY.equalToSuperview()
            make.width.equalTo(77)
        }
        
        /*
        bandwidthContainerView.snp.makeConstraints { make in
            make.height.equalTo(61)
        }
        
        bandwidthView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(21)
            make.centerY.equalToSuperview()
        }
        
        energyView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(bandwidthView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-21)
            make.centerY.equalToSuperview()
        }
         */
    }
    
    func setData(with recentTransactionModel: RecentTransactionModel?) {
        receiveImageView.image = "received_assets_icon".imageByName
        receiveTitleLabel.text = recentTransactionModel?.titleForDisplay
        receiveDateLabel.text = recentTransactionModel?.titleForDisplayCreationTime
        
        //bandwidthView.setData(with: "Bandwidth Points:", and: "1500B")
        //energyView.setData(with: "Energy:", and: "0", textAlignment: .right)
    }
    
    @objc private func openRecentRecordsPressed() {
        recentPressed()
    }
}
