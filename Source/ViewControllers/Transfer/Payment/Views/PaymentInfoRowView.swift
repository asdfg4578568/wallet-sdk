//
//  PaymentInfoRowView.swift
//  WalletSDK
//
//  Created by ashahrouj on 29/12/2022.
//

import UIKit
import SnapKit

class PaymentInfoRowView: UIView {
    
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
        label.textColor = .wWLightBlack
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    init(with iconName: String, titleInfo: (text:String, font: UIFont), subTitleInfo: (text:String, font: UIFont)) {
        
        super.init(frame: .zero)
        setupViews(with: iconName, titleInfo: titleInfo, subTitleInfo: subTitleInfo)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(with iconName: String, titleInfo: (text:String, font: UIFont), subTitleInfo: (text:String, font: UIFont)) {
        addSubview(containerView)
        containerView.addSubviews(with: [imageView, titleLabel, subTitleLabel])
        
        imageView.image = iconName.imageByName
        titleLabel.text = titleInfo.text
        titleLabel.font = titleInfo.font
        
        subTitleLabel.text = subTitleInfo.text
        subTitleLabel.font = subTitleInfo.font

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
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.lessThanOrEqualTo(166)
        }
    }
}
