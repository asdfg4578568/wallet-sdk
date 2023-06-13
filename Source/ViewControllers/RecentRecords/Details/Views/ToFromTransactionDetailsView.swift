//
//  ToFromTransactionDetailsView.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import UIKit

class ToFromTransactionDetailsView: UIView {

    private let containerStackViewView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    private let txIDTransactionRow: ToFromTransactionRow = {
        let view = ToFromTransactionRow(with: TransactionRowModel(iconName: "transaction_tx_id_icon", iconColor: .wBlueE6F, iconTitle: "Tx ID", title: "", shouldHideAddress: true))
        view.backgroundColor = .clear
        return view
    }()
    
    private let toTransactionRow: ToFromTransactionRow = {
        let view = ToFromTransactionRow(with: TransactionRowModel(iconName: "transaction_to_icon", iconColor: .wBlueE6F, iconTitle: "other_to_title".localized, title: ""))
        view.backgroundColor = .clear
        return view
    }()
    
    private let fromTransactionRow: ToFromTransactionRow = {
        let view = ToFromTransactionRow(with: TransactionRowModel(iconName: "transaction_from_icon", iconColor: .wBlueE6F, iconTitle: "other_from_title".localized, title: ""))
        view.backgroundColor = .clear
        return view
    }()
    
    var didTapOnSaveToMyAddress: (ToFromTransactionRow.ToFromRowTapAction) -> Void = {_ in }
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        containerStackViewView.backgroundColor = .clear
        addSubview(containerStackViewView)
        containerStackViewView.addArrangedSubview(txIDTransactionRow)
        containerStackViewView.addArrangedSubview(toTransactionRow)
        containerStackViewView.addArrangedSubview(fromTransactionRow)
        
        containerStackViewView.axis = .vertical
        containerStackViewView.spacing = 15
        
        txIDTransactionRow.didTapOnSaveToMyAddress = {[weak self] address in
            self?.didTapOnSaveToMyAddress(address)
        }
        
        fromTransactionRow.didTapOnSaveToMyAddress = {[weak self] address in
            self?.didTapOnSaveToMyAddress(address)
        }
        
        toTransactionRow.didTapOnSaveToMyAddress = {[weak self] address in
            self?.didTapOnSaveToMyAddress(address)
        }

    }
    
    func setupConstraints() {
        containerStackViewView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(15)
            make.trailing.equalTo(-15)
            make.bottom.equalTo(-15)
        }
    }

    func setData(with transactionHistoryModel: TransactionHistoryModel) {
        txIDTransactionRow.setData(with: transactionHistoryModel.transactionHash)
        toTransactionRow.setData(with: transactionHistoryModel.receiverAddress,
                                   info: transactionHistoryModel.receiverAddressForDisplay)
        fromTransactionRow.setData(with: transactionHistoryModel.senderAddress,
                                 info: transactionHistoryModel.senderAddressForDisplay)
    }
}
