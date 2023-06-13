//
//  PaymentInfoMinerFeeRowView.swift
//  WalletSDK
//
//  Created by ashahrouj on 29/12/2022.
//

import UIKit
import SnapKit

class PaymentInfoMinerFeeRowView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wWLightBlack
        label.textAlignment = .left
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .wBlue_49B.withAlphaComponent(0.08)
        label.textColor = .wBlue_39B
        label.textAlignment = .center
        label.font = .font(name: .semiBold, and: 14)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let secondSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wWLightBlack
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    let paymentInfoModel: PaymentInfoModel
    init(with paymentInfoModel: PaymentInfoModel) {
        self.paymentInfoModel = paymentInfoModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        subTitleLabel.corner(cornerRadius: 4)        
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [imageView, titleLabel, subTitleLabel, secondSubTitleLabel])
        
        imageView.image = paymentInfoModel.iconName.imageByName
        titleLabel.text = paymentInfoModel.titleInfo.text
        titleLabel.font = paymentInfoModel.titleInfo.font
        
        subTitleLabel.text = paymentInfoModel.subTitleInfo.text
        //subTitleLabel.font = paymentInfoModel.subTitleInfo.font

        secondSubTitleLabel.text = paymentInfoModel.secondSubTitleInfo?.text
        secondSubTitleLabel.font = paymentInfoModel.secondSubTitleInfo?.font
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
                //make.height.equalTo(32)
        }
        
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.width.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.centerY.equalTo(imageView)
            make.height.equalTo(21)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.width.lessThanOrEqualTo(117)
            make.height.equalTo(29)
        }
        
        secondSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(18)
        }
    }
}
