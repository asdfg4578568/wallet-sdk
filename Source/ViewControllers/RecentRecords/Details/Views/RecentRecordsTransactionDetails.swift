//
//  RecentRecordsTransactionDetails.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import UIKit
import SnapKit

class RecentRecordsTransactionDetails: UIView {

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 15
        return view
    }()
    
    private let txIDTransactionRow: ToFromTransactionDetailsView = {
        let view = ToFromTransactionDetailsView()
        return view
    }()
    
    private let timeGasRowView: TimeGasTransactionDetailsView = {
        let view = TimeGasTransactionDetailsView()
        return view
    }()
    
    var didTapOnSaveToMyAddress: (ToFromTransactionRow.ToFromRowTapAction) -> Void = {_ in }
    init(shouldHideTimeGasSection: Bool) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        timeGasRowView.isHidden = shouldHideTimeGasSection
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.backgroundColor = .wWhite
        containerView.corner()
        containerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    
        txIDTransactionRow.backgroundColor = .wWhite
        txIDTransactionRow.corner()
        txIDTransactionRow.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(containerStackView)
        containerStackView.addArrangedSubview(timeGasRowView)
        containerStackView.addArrangedSubview(txIDTransactionRow)
        
        txIDTransactionRow.didTapOnSaveToMyAddress = {[weak self] address in
            guard let self = self else { return }
            self.didTapOnSaveToMyAddress(address)
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(24)
            make.trailing.equalTo(-24)
            make.bottom.equalTo(-15)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.bottom.equalTo(-15)
        }
    }

    func setData(with transactionHistoryModel: TransactionHistoryModel, and shouldHideTimeGasSection: Bool) {
        timeGasRowView.isHidden = shouldHideTimeGasSection
        txIDTransactionRow.setData(with: transactionHistoryModel)
        timeGasRowView.setData(with: transactionHistoryModel)
    }
    
}
