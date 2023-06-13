//
//  TransactionsHistoryViewCell.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/12/2022.
//

import UIKit

class TransactionsHistoryViewCell: UITableViewCell {

    private let containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let iconImageView: UIImageView = {
       let view = UIImageView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(name: .regular, and: 18)
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .font(name: .regular, and: 12)
        label.textColor = .wWLightBlack
        label.lineBreakMode = .byTruncatingMiddle
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .font(name: .regular, and: 12)
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .font(name: .regular, and: 12)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.addGradientLayer(with: [UIColor.wGrayF7F.cgColor, UIColor.wWhite.cgColor])
        containerView.corner(borderWidth: 2, borderColor: .wWhite)
        containerView.dropShadow(with: UIColor.wWLightLightGray.cgColor, onlyBottom: false)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [iconImageView, titleLabel, addressLabel, amountLabel, statusLabel])
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.height.width.equalTo(36)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(65)
        }
        
        amountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(amountLabel.snp.bottom)
            make.leading.equalTo(addressLabel.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-15)
            make.width.greaterThanOrEqualTo(60)
        }
    }

    func setData(with model: TransactionHistoryModel) {
        iconImageView.image = model.option.transactionsIcon.imageByName
        titleLabel.text = model.option.transactionsTitle
        titleLabel.textColor = model.option.transactionsTitleColor
        addressLabel.text = model.isSend ? model.receiverAddress : model.senderAddress
        amountLabel.text = model.amountForDisplayInHistoryList

        statusLabel.text = model.status.title
        statusLabel.textColor = model.status.color
        statusLabel.isHidden = model.option == .receive
    }
}
