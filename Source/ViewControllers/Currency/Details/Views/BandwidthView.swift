//
//  BandwidthView.swift
//  WalletSDK
//
//  Created by ashahrouj on 19/12/2022.
//

import Foundation
import SnapKit

class BandwidthView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let bandwidthView: TitleAndSubtitleView = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .regular, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .semiBold, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
                                                                
    private let energyView: TitleAndSubtitleView = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .regular, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .semiBold, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
    
    
    var recentPressed: () -> Void = {}
    
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
        addSubview(containerView)
        containerView.addSubviews(with: [bandwidthView, energyView])
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
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
        
    }
    
    func setData() {
        
        
        bandwidthView.setData(with: "currency_details_bandwidth_points".localized, and: "1500B")
        energyView.setData(with: "currency_details_energy".localized, and: "0")
    }
    
}
