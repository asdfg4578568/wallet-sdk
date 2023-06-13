//
//  ReceivingAddressView.swift
//  WalletSDK
//
//  Created by ashahrouj on 26/12/2022.
//

import UIKit
import SnapKit

class ReceivingAddressView: UIView {
   
    var didAddressPressed: (Bool) -> Void = {_ in }
    var didScanPressed: () -> Void = { }

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "receiving_address_title".localized
        label.font = UIFont.font(name: .semiBold, and: 16)
        return label
    }()
    
    private let addressButton: CircleButton = {
        let button = CircleButton()
        return button
    }()

    private let scanButton: CircleButton = {
        let button = CircleButton()
        return button
    }()
    
    private let containerForTextFieldView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let assestButton: CircleButton = {
        let button = CircleButton()
        return button
    }()
    
    var didEnterAddress: (String) -> Void = {_ in }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        containerForTextFieldView.addGradientLayer(with: [UIColor.wMidLightGray.cgColor, UIColor.wWhite.cgColor])
        containerForTextFieldView.corner(cornerRadius: 8, borderColor: .wWhite)
        containerForTextFieldView.dropShadow(with: UIColor.wWLightDarkGray.cgColor, onlyBottom: true)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, addressButton, scanButton, containerForTextFieldView])
        containerForTextFieldView.addSubviews(with: [textField, assestButton])
        
        textField.delegate = self
        addressButton.pressed = {
            self.didAddressPressed(true)
        }
        
        scanButton.pressed = {
            self.didScanPressed()
        }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        addressButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(15)
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(36)
        }
        
        scanButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(addressButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(36)
        }
        
        containerForTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-17)
            make.height.equalTo(57)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        assestButton.snp.makeConstraints { make in
            make.leading.equalTo(textField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(textField)
            make.height.width.equalTo(41)
        }
        
    }
    
    func setData(currencyModel: CurrencyModel) {
        textField.placeholder = String(format: "receiving_enter_address_title".localized, currencyModel.asset.name)
        addressButton.setData(with: .wWLightLightGray, and: "transfer_address_icon")
        scanButton.setData(with: .wWLightLightGray, and: "transfer_scan_icon")
        assestButton.setData(with: currencyModel.asset.homeIconBackgroundColor, and: currencyModel.asset.iconName)
    }
    
    func updateAddressTextField(with text: String) {
        self.textField.text = text
    }
}

extension ReceivingAddressView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        didEnterAddress(newString)
        return range.location < 42
    }
}
