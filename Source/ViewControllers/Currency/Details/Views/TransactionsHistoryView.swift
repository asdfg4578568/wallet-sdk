//
//  TransactionsHistoryView.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/12/2022.
//

import Foundation
import SnapKit
import XLPagerTabStrip

class TransactionsHistoryView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .clear
        label.textColor = .wBlack
        label.font = .font(name: .semiBold, and: 16)
        label.text = "currency_details_transactions_history".localized
        return label
    }()
    
    private lazy var noResultStack: UIStackView = {
        let icon = UIImageView()
        icon.image = "no_data_found_tranaction_history".imageByName
        icon.contentMode = .scaleAspectFit
        
        let title = UILabel()
        title.text = "no_data_found".localized
        title.textColor = .wGray646
        title.font = .font(name: .semiBold, and: 16)
        
        let vStack = UIStackView.init(arrangedSubviews: [icon,title])
        vStack.distribution = .fill
        vStack.alignment = .center
        vStack.spacing = 10
        vStack.axis = .vertical
        return vStack
    }()
    
    private(set) var viewController: TransactionsHistoryPagerTab
    
    var didTapOnTransaction: (TransactionHistoryModel) -> Void = {_ in }

    private var transactionOption: TransactionsHistoryOptions
    init(with transactionOption: TransactionsHistoryOptions, and coinType: Int) {
        self.transactionOption = transactionOption
        self.viewController = TransactionsHistoryPagerTab(with: coinType)
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.corner(borderWidth: 2, borderColor: .wWhite)
        containerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
    }
    
    func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, viewController.view])
        
        self.viewController.didTapOnTransaction = { [weak self] model in
            self?.didTapOnTransaction(model)
        }
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        viewController.view.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    func setData() { }
}


extension TransactionsHistoryView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TransactionsHistoryOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = TransactionsHistoryOptions.allCases[section]
        
        // return messageList.count > 3 ? 3 : messageList.count
        switch section {
        case .all:
            return 5
        case .send:
            return 5
        case .receive:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = TransactionsHistoryOptions.allCases[indexPath.section]
        switch section {
        case .all, .send, .receive:
            let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsHistoryViewCell.className) as! TransactionsHistoryViewCell
            cell.backgroundColor = .blue
            return cell
        }
    }
}
