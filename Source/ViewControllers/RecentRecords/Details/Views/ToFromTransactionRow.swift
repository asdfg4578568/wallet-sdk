//
//  ToFromTransactionRow.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import UIKit
import SnapKit

class ToFromTransactionRow: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let circleWithTitle: CircleButtonWithTitle = {
        let button = CircleButtonWithTitle(size: .size32, fontForLabel: UIFont.font(name: .semiBold, and: 16))
        return button
    }()
    
    private let copyAddressButton: CircleButton = {
        let button = CircleButton()
        return button
    }()

    private let addressStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textAlignment = .right
        label.font = UIFont.font(name: .regular, and: 12)
        label.textColor = .wBlack42
        return label
    }()
    
    private let savedAddressButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.font(name: .regular, and: 12)
        button.titleLabel?.textAlignment = .right
        button.setTitle("transfer_save_my_address_book".localized, for: .normal)
        button.setTitleColor(.wBlue3A8, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    enum ToFromRowTapAction {
        case copy(String)
        case save(String)
        case open(String)

    }
    var didTapOnSaveToMyAddress: (ToFromRowTapAction) -> Void = {_ in }
    
    private var transactionRowModel: TransactionRowModel
    init(with transactionRowModel: TransactionRowModel) {
        self.transactionRowModel = transactionRowModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        fillData()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        savedAddressButton.corner(cornerRadius: 5)
    }
    
    func setupViews() {
        backgroundColor = .wGray8
        addSubview(containerView)
        containerView.addSubviews(with: [circleWithTitle, addressStackView, copyAddressButton])
        addressStackView.addArrangedSubview(addressLabel)
        addressStackView.addArrangedSubview(savedAddressButton)
        addressStackView.axis = .vertical
        
        savedAddressButton.addTarget(self, action: #selector(savedAddressPressed), for: .touchUpInside)
        copyAddressButton.addTarget(self, action: #selector(copyAddressPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        circleWithTitle.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(CircleButtonWithTitle.CircleButtonSize.size32.rawValue)
        }
        
        addressStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(circleWithTitle.snp.trailing).offset(15)
            make.bottom.equalTo(-5)
        }
        
        copyAddressButton.snp.makeConstraints { make in
            make.top.equalTo(3)
            make.leading.equalTo(addressStackView.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.height.width.equalTo(26)
        }
    }

    func fillData() {
        
        circleWithTitle.setData(with: transactionRowModel.iconTitle, and: transactionRowModel.iconName, backgroundColor: transactionRowModel.iconColor)
        copyAddressButton.setData(with: .wBlueEB, and: "transaction_copy_address_icon")
        addressLabel.text = transactionRowModel.title
        savedAddressButton.isHidden = transactionRowModel.shouldHideAddress
    }
    

    func setData(with address: String) {
        transactionRowModel.title = address
        
        let attributedString = NSMutableAttributedString.init(string: address)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.wPurpl, range: NSRange.init(location: 0, length: attributedString.length))
        addressLabel.attributedText = attributedString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addressTapped(_:)))
        addressLabel.isUserInteractionEnabled = true
        addressLabel.addGestureRecognizer(tapGesture)
    }

    func setData(with address: String, info: (title: String, hideBackgoundColor: Bool)) {
        addressLabel.text = address
        transactionRowModel.title = address
        savedAddressButton.setTitle(info.title, for: .normal)
        savedAddressButton.backgroundColor = info.hideBackgoundColor ? .clear : .wBlueEB
        savedAddressButton.contentHorizontalAlignment = info.hideBackgoundColor ? .right : .center
        savedAddressButton.isEnabled = info.hideBackgoundColor ? false : true
    }
    
    @objc func savedAddressPressed() {
        didTapOnSaveToMyAddress(.save(transactionRowModel.title))
    }
    
    @objc func copyAddressPressed() {
        didTapOnSaveToMyAddress(.copy(transactionRowModel.title))
    }
    
    @objc func addressTapped(_ sender: UITapGestureRecognizer) {
        didTapOnSaveToMyAddress(.open(transactionRowModel.title))
    }
}
