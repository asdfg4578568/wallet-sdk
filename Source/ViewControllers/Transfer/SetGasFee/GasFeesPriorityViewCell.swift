//
//  GasFeesPriorityViewCell.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import UIKit
import SnapKit

class GasFeesPriorityViewCell: UITableViewCell {

    private let containerView: UIView = {
       let view = UIView()
        return view
    }()

    private let priorityImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 16)
        return label
    }()
    
    private let feesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 14)
        return label
    }()
    
    private let selectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = "selected_gas_fees_icon".imageByName
        return imageView
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
        
        containerView.corner()
        containerView.dropShadow(with: UIColor.wWhite.cgColor, onlyBottom: false)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [priorityImageView, titleLabel, feesLabel, selectedImageView])
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        priorityImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(priorityImageView.snp.trailing).offset(15)
            make.centerY.equalTo(priorityImageView)
        }
        
        feesLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
            make.centerY.equalTo(priorityImageView)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.leading.equalTo(feesLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(priorityImageView)
            make.height.width.equalTo(14)
        }
        
    }
    
    var model: GasFeesPriorityModel?
    func setData(with model: GasFeesPriorityModel) {
        self.model = model
        
        containerView.backgroundColor = model.isSelected ? .wBlue_E4F : .wGrayFAF
        titleLabel.text = model.type.title
        feesLabel.textColorChange(fullText: "\("transfer_max_fee".localized) \(model.price.descriptionFor12Digits) \(model.asset.name)", changeText: "\(model.asset.name)", color: .wWLightBlack, font: .font(name: .semiBold, and: 14))
        priorityImageView.image = model.type.iconName.imageByName
        selectedImageView.isHidden = !model.isSelected
    }
}
