//
//  CurrencyDetailsViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 19/12/2022.
//

import UIKit
import SnapKit

class CurrencyDetailsViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let assestCardView: CurrencyAssetCardView
    
//    private let bandwidthView: BandwidthView = {
//        let view = BandwidthView()
//        return view
//    }()
    
    private var transactionsHistoryView: TransactionsHistoryView
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let transferButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .wBlack
        button.setTitle("currency_details_transfer".localized, for: .normal)
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 15)
        return button
    }()
    
    private let receiveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .wWhite
        button.setTitle("currency_details_receive".localized, for: .normal)
        button.setTitleColor(.wBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 15)
        return button
    }()
    
    private var viewModel: CurrencyDetailsViewModel
    init(with viewModel: CurrencyDetailsViewModel) {
        self.viewModel = viewModel
        self.assestCardView = CurrencyAssetCardView(with: CurrencyAssetCardModel(mainColor: .wWhite, cardColor: viewModel.currencyModel.asset.cardBackgroundColor, assetName: viewModel.currencyModel.asset.name, assetIconBackgroundColor: viewModel.currencyModel.asset.cardIconBackgroundColor, assetIconName: viewModel.currencyModel.asset.iconName, assetAmount: ""), shouldDisplayRefreshButton: true)
        self.transactionsHistoryView = TransactionsHistoryView(with: .all, and: viewModel.currencyModel.coinType)
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButtonForXlink()
        
        self.transferButton.isExclusiveTouch = true
        self.receiveButton.isExclusiveTouch = true
        
        title = "currency_details_title".localized
        transferButton.corner(cornerRadius: 5)
        receiveButton.corner(cornerRadius: 5)
        receiveButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.25)
        
        transactionsHistoryView.didTapOnTransaction = {[weak self] model in
            guard let self = self else { return }
            self.navigationController?.pushViewController(RecentRecordsDetailsViewController(with: RecentRecordsDetailsViewModel(with: self.viewModel.currencyModel, and: model.transactionHash, status: model.status)), animated: true)
        }
        
        assestCardView.refreshButton.pressed = {[weak self] in
            guard let self = self else { return }
            self.fetchData()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    private func fetchData() {
        
        self.transferButton.isUserInteractionEnabled = false
        self.receiveButton.isUserInteractionEnabled = false
        let dispatchGroup = DispatchGroup()
        Spinner.start()
        
        viewModel.getBalance { [weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                self.assestCardView.setAsset(for: self.viewModel.currencyModel.amount)
                self.transactionsHistoryView.viewController.allVC.setDispatchGroup(with: dispatchGroup)
                self.transactionsHistoryView.viewController.allVC.callPullToRefresh()
                self.transactionsHistoryView.viewController.sendVC.setDispatchGroup(with: dispatchGroup)
                self.transactionsHistoryView.viewController.sendVC.callPullToRefresh()
                self.transactionsHistoryView.viewController.receiveVC.setDispatchGroup(with: dispatchGroup)
                self.transactionsHistoryView.viewController.receiveVC.callPullToRefresh()
                
                dispatchGroup.notify(queue: .main, execute: {
                    Spinner.stop()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {[weak self] in
                        self?.transferButton.isUserInteractionEnabled = true
                        self?.receiveButton.isUserInteractionEnabled = true
                    })
                })
            } else {
                self.displayTryAgain {[weak self] in
                    self?.fetchData()
                }
            }
        }
    }
    
    func setupViews() {
        view.backgroundColor = .wWhite
        view.addSubview(containerView)
        containerView.addSubview(assestCardView)
        //if viewModel.shouldDisplayBandwidth { containerView.addSubview(bandwidthView) }
        containerView.addSubview(transactionsHistoryView)
        containerView.addSubview(containerStackView)
        containerStackView.addArrangedSubviews(with: [transferButton, receiveButton])
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.distribution = .fillEqually
        containerStackView.alignment = .fill
        
        receiveButton.addTarget(self, action: #selector(receivePressed), for: .touchUpInside)
        transferButton.addTarget(self, action: #selector(transferPressed), for: .touchUpInside)

    }

    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        assestCardView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(110)
        }
        
//        if viewModel.shouldDisplayBandwidth {
//            bandwidthView.snp.makeConstraints { make in
//                make.top.equalTo(assestCardView.snp.bottom)
//                make.leading.trailing.equalToSuperview()
//            }
//        }
        
        transactionsHistoryView.snp.makeConstraints { make in
            //make.top.equalTo(viewModel.shouldDisplayBandwidth ? bandwidthView.snp.bottom : assestCardView.snp.bottom)
            make.top.equalTo(assestCardView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(transactionsHistoryView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(-25)
            make.height.equalTo(45)
        }
    }
    
    @objc private func transferPressed() {
        self.navigationController?.pushViewController(TransferViewController(with: TransferViewModel(with: viewModel.currencyModel)), animated: true)
    }
    
    @objc private func receivePressed() {
        self.navigationController?.pushViewController(ReceiveViewController(with: ReceiveViewModel(with: viewModel.currencyModel)), animated: true)
    }
    
}
