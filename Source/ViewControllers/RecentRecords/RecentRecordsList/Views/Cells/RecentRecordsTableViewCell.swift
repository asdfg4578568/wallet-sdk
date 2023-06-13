//
//  RecentRecordsTableViewCell.swift
//  WalletSDK
//
//  Created by ashahrouj on 15/12/2022.
//

import UIKit
import SnapKit
import SwipeCellKit

class RecentRecordsTableViewCell: SwipeTableViewCell {

    private let containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let readCircleView: UIView = {
       let view = UIView()
        view.backgroundColor = .wDarkRed
        return view
    }()
    
    private let circleStatusButton: CircleButton = {
        let circleStatus = CircleButton()
        return circleStatus
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .font(name: .semiBold, and: 14)
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .font(name: .regular, and: 12)
        label.textAlignment = .right
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .font(name: .bold, and: 12)
        label.textAlignment = .right
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let arrowButton: CircleButton = {
        let circleStatus = CircleButton()
        return circleStatus
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
        containerView.addGradientLayer(with: [UIColor.wWLightLightGray.cgColor, UIColor.wWhite.cgColor])
        containerView.corner(borderWidth: 2, borderColor: .wWhite)
        containerView.dropShadow(with: UIColor.wWLightLightGray.cgColor, onlyBottom: false)
        
        readCircleView.corner(cornerRadius: readCircleView.layer.bounds.width / 2)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [readCircleView, circleStatusButton, statusLabel, containerStackView, arrowButton])
        containerStackView.addArrangedSubview(amountLabel)
        containerStackView.addArrangedSubview(dateLabel)
        
        containerStackView.axis = .vertical
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        readCircleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(8)
        }
        
        circleStatusButton.snp.makeConstraints { make in
            make.leading.equalTo(readCircleView.snp.trailing).offset(2)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(46)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(circleStatusButton.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(statusLabel.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(41)
        }
        
        arrowButton.snp.makeConstraints { make in
            make.leading.equalTo(containerStackView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }
    }
    
    func setData(with model: RecentTransactionModel ) {
        readCircleView.isHidden = true // later 
        arrowButton.setData(with: .wGray, and: "arrow_left_dark_gray_icon")
        circleStatusButton.setData(with: .clear, and: model.iconForDisplayInList)
        statusLabel.text = model.titleForDisplayInList
        amountLabel.text = model.amountForDisplayInList
        dateLabel.text = model.titleForDisplayCreationTime
    }
}
