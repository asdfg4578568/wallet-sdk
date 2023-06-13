//
//  EmptyView.swift
//  WalletSDK
//
//  Created by ashahrouj on 21/12/2022.
//

import UIKit

class EmptyView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .wGray646
        label.font = .font(name: .semiBold, and: 16)
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    private var title: String
    private var iconName: String
    
    init(with title: String, iconName: String) {
        self.title = title
        self.iconName = iconName
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [iconImageView, titleLabel])
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }
    }
    
    private func setData() {
        titleLabel.text = title
        iconImageView.image = iconName.imageByName
    }
}
