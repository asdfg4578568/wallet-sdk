//
//  TransferAmountView.swift
//  WalletSDK
//
//  Created by ashahrouj on 26/12/2022.
//

import UIKit
import SnapKit

class TransferAmountView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "transfer_amount_title".localized
        label.font = UIFont.font(name: .semiBold, and: 16)
        return label
    }()
    
    private let containerForAmountView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let assestButton: CircleButton = {
        let button = CircleButton()
        button.setData(with: .wDarkPurpl, and: "asset_usdt_eth_icon")
        return button
    }()
    
    private let assesstTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00000000  ≈"
        label.textColor = .wWLightBlack
        label.textAlignment = .left
        label.font = UIFont.font(name: .semiBold, and: 18)
        return label
    }()
    
    private let assesstTotalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0.00000000 "
        textField.textColor = .wWLightBlack
        textField.textAlignment = .left
        textField.font = UIFont.font(name: .semiBold, and: 18)
        textField.keyboardType = .decimalPad
        textField.tag = TextFieldOrder.assesstTotal.rawValue
        return textField
    }()
    
    private let equalSymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "≈   "
        label.textColor = .wWLightBlack
        label.textAlignment = .right
        label.font = UIFont.font(name: .semiBold, and: 18)
        return label
    }()
    
    private let currencyTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.textColor = .wWLightDarkGray
        label.textAlignment = .right
        //label.adjustsFontSizeToFitWidth = true
        //label.minimumScaleFactor = 0.6
        label.font = UIFont.font(name: .semiBold, and: 18)
        return label
    }()
    
    
    
    /*
    private let normalCurrencyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "¥0.00"
        textField.textColor = .wWLightDarkGray
        textField.textAlignment = .right
        textField.font = UIFont.font(name: .semiBold, and: 24)
        textField.keyboardType = .decimalPad
        textField.tag = TextFieldOrder.normalCurrency.rawValue
        return textField
    }()
    */
    private let containerForBalanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 12)
        label.textColor = .wWLightBlack
        label.textAlignment = .center
        return label
    }()
    
    private let balanceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .wLightLightBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        button.setTitle("other_all_title".localized, for: .normal)
        button.setTitleColor(.wWhite, for: .normal)
        return button
    }()
    
    enum BalanceAllOptions {
        case toZero
        case other
    }
    
    enum ChangeCurrencyType {
        case all(BalanceAllOptions)
        case balancToSend(String)
        case normalCurrency(String)
    }
    
    enum TextFieldOrder: Int {
        case assesstTotal = 1
        case normalCurrency = 2
    }
    
    var didEnter: (ChangeCurrencyType) -> Void = {_ in }
    
    private var asset: CurrencyAssetsEnum
    init(with asset: CurrencyAssetsEnum) {
        self.asset = asset
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerForAmountView.backgroundColor = .wBlueE6E
        containerForAmountView.corner()
        containerForAmountView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
        containerForBalanceView.corner(cornerRadius: 20)
        balanceButton.corner(cornerRadius: 20)
        
        assesstTotalTextField.delegate = self
        //normalCurrencyTextField.delegate = self
    }
    
    func setupViews() {
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, containerForAmountView])
        containerForAmountView.addSubviews(with: [assestButton, assesstTotalTextField, equalSymbolLabel, currencyTotalLabel, containerForBalanceView, balanceButton])
        containerForBalanceView.addSubview(balanceLabel)
        
        addToolBar(for: assesstTotalTextField)
        //addToolBar(for: normalCurrencyTextField)
        balanceButton.addTarget(self, action: #selector(allPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        containerForAmountView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(18)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(136)
            make.bottom.equalToSuperview()
        }
        
        assestButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(38)
        }
        
        assesstTotalTextField.snp.makeConstraints { make in
            make.leading.equalTo(assestButton.snp.trailing).offset(15)
            make.centerY.equalTo(assestButton)
        }
        
        equalSymbolLabel.snp.makeConstraints { make in
            make.leading.equalTo(assesstTotalTextField.snp.trailing).offset(10)
            make.centerY.equalTo(assestButton)
            make.width.equalTo(16)
        }
        
        currencyTotalLabel.snp.makeConstraints { make in
            make.leading.equalTo(equalSymbolLabel.snp.trailing)
            make.centerY.equalTo(assestButton)
            make.trailing.equalToSuperview().offset(-20)
            make.width.greaterThanOrEqualTo(120)
        }
        
        containerForBalanceView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(37)
            make.width.lessThanOrEqualTo(177)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
        
        balanceButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-12)
            make.height.equalTo(37)
            make.width.equalTo(80)
        }
    }
    
    private func addToolBar(for textfiled: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "other_done_title".localized, style: .plain, target: self,
                                         action: #selector(dismiss))
        button.setTitleTextAttributes([.foregroundColor: UIColor.wLightLightBlue], for: .normal)

        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        textfiled.inputAccessoryView = toolBar
    }
    private func setData() {
        assestButton.setData(with: asset.homeIconBackgroundColor, and: asset.iconName)
    }
    
    @objc private func allPressed() {
        didEnter(.all(.other))
    }
    
    func updateUI(with totalBalance: String, balanceToSend: String, currencyBalance: String) {
        let assetName = asset.name
        balanceLabel.textColorChange(fullText: "\("transfer_amount_bl_title".localized)\(totalBalance) \(assetName)", changeText: "\(assetName)", color: .wWLightBlack, font: .font(name: .semiBold, and: 12))
        assesstTotalTextField.text = "\(balanceToSend)"
        currencyTotalLabel.text = "\(currencyBalance)"
    }
}

extension TransferAmountView: UITextFieldDelegate {
    
    @objc func dismiss() {
       endEditing(true)
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { true }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        guard let _ = NumberFormatter().number(from: newString)?.doubleValue else { // check if the string is correct double
            if newString.isEmpty { didEnter(.balancToSend(newString)) } // this when you removed last letter in the textfiled.
            return false
        }
        
        let formatter = NumberFormatter()
        let localizedSeparator = formatter.decimalSeparator!
        var reg = "^[0-9]{0,15}([\(localizedSeparator)][0-9]{0,6})?$"
        if asset == .eth || asset == .btc { reg = "^[0-9]{0,15}([\(localizedSeparator)][0-9]{0,8})?$" }
        let matchesInputFormat = newString.range(of: reg, options: .regularExpression) != nil
        
        if matchesInputFormat {
            let type: ChangeCurrencyType = textField.tag == TransferAmountView.TextFieldOrder.assesstTotal.rawValue ? .balancToSend(newString) : .normalCurrency(newString)
            didEnter(type)
        }
        
        return false
    }
}
