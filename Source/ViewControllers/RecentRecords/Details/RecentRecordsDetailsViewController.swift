//
//  RecentRecordsDetailsViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import UIKit
import SnapKit

public class RecentRecordsDetailsViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .wWhite
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let statusButton: CircleButton = {
        let circleButton = CircleButton()
        return circleButton
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font(name: .semiBold, and: 16.5)
        label.textColor = .wDarkGreen3
        return label
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_done_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        button.isHidden = true
        return button
    }()
    
    private let assestCardView: CurrencyAssetCardView
    private let detailsTransaction: RecentRecordsTransactionDetails
       
    let viewModel: RecentRecordsDetailsViewModel
    public init(with viewModel: RecentRecordsDetailsViewModel) {
        self.viewModel = viewModel
       
        let currencyModel = viewModel.currencyModel
        self.assestCardView = CurrencyAssetCardView(with: CurrencyAssetCardModel(mainColor: .wWhite, cardColor: currencyModel.asset.cardBackgroundColor, assetName: currencyModel.asset.name, assetIconBackgroundColor: currencyModel.asset.cardIconBackgroundColor, assetIconName: currencyModel.asset.iconName, assetAmount: ""))
        
        self.detailsTransaction = RecentRecordsTransactionDetails(shouldHideTimeGasSection: viewModel.shouldHideTimeGasSection)
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButtonForXlink()
        fetchTransactionDetails()
    }
    
    private func fetchTransactionDetails() {
        Spinner.start()
        viewModel.fetchTransaction { [weak self] result in
            Spinner.stop()
            guard let self = self else { return }
            switch result {
            case true:
                self.setData()
            case false:
                self.displayTryAgain {[weak self] in
                    self?.fetchTransactionDetails()
                }
            }
        }
    }
    
    func refresh() {
        fetchTransactionDetails()
    }
    
    func setupViews() {
        view.backgroundColor = .wWhite
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [statusButton, titleLabel, assestCardView, detailsTransaction, doneButton])
        doneButton.corner(cornerRadius: 28)
        doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        
        detailsTransaction.didTapOnSaveToMyAddress = {[weak self] type in
            guard let self = self else { return }
            
            switch type {
            case .save(let address):
                self.navigationController?.pushViewController(AddAddressViewController(with: AddAddressViewModel(with: self.viewModel.currencyModel, and: address)), animated: true)

            case .copy(let address):
                self.showToast(with: "toast_copied".localized)
                UIPasteboard.general.string = address
                
            case .open(let address):
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(WebViewController(with: "\(self.viewModel.tansactionBaseUrl)\(address)"), animated: true)
                }
            }
        }
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(52)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(statusButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        assestCardView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(110)
        }
        
        detailsTransaction.snp.makeConstraints { make in
            make.top.equalTo(assestCardView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(detailsTransaction.snp.bottom).offset(40)
            make.leading.equalTo(35)
            make.trailing.equalTo(-35)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(55)
        }
    }
    
    func setData() {
        doneButton.isHidden = viewModel.status != .pending
        statusButton.setData(with: .clear, and: viewModel.status.detailsIcon)
        titleLabel.text = viewModel.status.title
        titleLabel.textColor = viewModel.status.color
        
        guard let transactionHistoryModel = self.viewModel.transactionHistoryModel else { return }
        self.detailsTransaction.setData(with: transactionHistoryModel, and: viewModel.shouldHideTimeGasSection)
        self.assestCardView.setAsset(for: transactionHistoryModel.amount.descriptionFor8Digits)
        title = transactionHistoryModel.isSend ? "recent_records_transfer_details_title".localized : "recent_records_deposit_details_title".localized
    }
    
    @objc private func donePressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
