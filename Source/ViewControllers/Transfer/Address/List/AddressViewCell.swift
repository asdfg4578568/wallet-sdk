//
//  AddressViewCell.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import UIKit
import SnapKit
import SwipeCellKit

class AddressViewCell: SwipeTableViewCell {

    private let blueContainerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let whiteContainerView: UIView = {
       let view = UIView()
        return view
    }()
    
    private let containerLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private let containerForTitlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = 10
        return stackView
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "other_name_title".localized
        label.textColor = .wWLightBlack
        label.font = UIFont.font(name: .semiBold, and: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wWLightBlack
        label.font = UIFont.font(name: .regular, and: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let containerForVluesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        //stackView.spacing = 10
        return stackView
    }()
    
    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "other_address_title".localized
        label.textColor = .wWLightBlack
        label.font = UIFont.font(name: .semiBold, and: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wBlue_2A6
        label.font = UIFont.font(name: .regular, and: 14)
        label.textAlignment = .left
        return label
    }()
    
    private let copyAddressButton: CircleButton = {
        let button = CircleButton()
        return button
    }()
    
    var didCopyPressed: (AddressModel) -> Void = {_ in }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        contentView.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        whiteContainerView.addGradientLayer(with: [UIColor.wWLightLightGray.cgColor, UIColor.wWhite.cgColor])
        whiteContainerView.corner()
        whiteContainerView.dropShadow(with: UIColor.wWLightLightGray.cgColor, onlyBottom: false)
        
        blueContainerView.backgroundColor = .wBlueE6E
        blueContainerView.corner()
        blueContainerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    }
    
    func setupViews() {
        addSubview(blueContainerView)
        blueContainerView.addSubview(whiteContainerView)
        whiteContainerView.addSubviews(with:[containerLabelsStackView, copyAddressButton])
        containerLabelsStackView.addArrangedSubviews(with: [containerForTitlesStackView, containerForVluesStackView])
        containerForTitlesStackView.addArrangedSubviews(with: [nameTitleLabel, addressTitleLabel])
        containerForVluesStackView.addArrangedSubviews(with: [nameLabel, addressLabel])
        
        copyAddressButton.pressed = {[weak self] in
            guard let self = self, let addrees = self.addrees else { return }
            self.didCopyPressed(addrees)
        }
    }
    
    func setupConstraints() {
        blueContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        whiteContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        containerLabelsStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        copyAddressButton.snp.makeConstraints { make in
            make.leading.equalTo(containerLabelsStackView.snp.trailing).offset(15)
            make.trailing.lessThanOrEqualToSuperview().offset(-10)
            make.height.width.equalTo(26)
            make.bottom.equalToSuperview().offset(-5)
        }
        
    }
    
    private var addrees: AddressModel?
    func setData(with addrees: AddressModel) {
        self.addrees = addrees
        addressLabel.text = addrees.address
        nameLabel.text = addrees.name
        copyAddressButton.setData(with: .wBlueEB, and: "transaction_copy_address_icon")
    }
}
