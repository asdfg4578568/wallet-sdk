//
//  CurrencyViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import UIKit
import SnapKit

public class CurrencyViewController: UIViewController {

    var refreshControl = UIRefreshControl()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .wWhite
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .wWhite
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let pressentAssetsView: CurrencyPressentAssetsView = {
        let view = CurrencyPressentAssetsView()
        return view
    }()
    
    private let receiveAndBandwidthView: CurrencyReceiveAndBandwidthView = {
        let view = CurrencyReceiveAndBandwidthView()
        view.isHidden = true
        return view
    }()
    
    private let assetsCotainerView: CurrencyAssetsCotainerView = {
        let view = CurrencyAssetsCotainerView()
        return view
    }()
    
    private var viewModel: CurrencyViewModel
    public init(with viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
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
        self.viewModel.updateCoinStatuses()
        self.viewModel.fetchLocalCoins()
        self.viewModel.didFinishFetchLocal = { [weak self] isSuccess in
            guard let self = self else { return }
            self.setData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                if DefaultsKeys.shouldDisplayTutorialHomeScreen {
                    UserDefaults.standard.set(true, forKey: DefaultsKeys.tutorialHomeScreen) // I have to create a manager to handle anything inside it for 'UserDefaults'
                    self.displayTutorialPopup()
                }
            })
        }
        
        self.viewModel.didFinishFetchData = {[weak self] isSuccess in
            guard let self = self else { return }
            self.refreshControl.endRefreshing()
            //if self.viewModel.shouldDisplaySpinner { Spinner.stop() }
            if isSuccess {
                self.viewModel.shouldDisplaySpinner = false
                self.setData()
            }
        }
        
        receiveAndBandwidthView.recentPressed = {
            self.navigationController?.pushViewController(RecentRecordsViewController(with: RecentRecordsViewModel()), animated: true)
        }
        
        pressentAssetsView.didTapEyePressed = {[weak self] in
            guard let self = self else { return }
            self.viewModel.shouldHideData.toggle()
            self.setData()
        }
        
        pressentAssetsView.didTapBuyPressed = {[weak self] in
            guard let self = self else { return }
            self.displayPopupGoToThirdParty()
        }
        
        pressentAssetsView.didTapRefreshPressed = {[weak self] in
            guard let self = self else { return }
            self.refreshData(shouldDisplaySpinner: true)
        }
    }
    
    private func refreshData(shouldDisplaySpinner: Bool = false) {
        if shouldDisplaySpinner {
            //DispatchQueue.main.async { Spinner.start() }
            viewModel.shouldDisplaySpinner = shouldDisplaySpinner
        }
        self.viewModel.fetchAllBalanceData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global().async {
            self.refreshData(shouldDisplaySpinner: self.viewModel.shouldDisplaySpinner)
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.removeViewControllerPreviousHome()
        SDKManager.shared.currencyModel = nil
        NotificationCenter.default.addObserver(self, selector: #selector(self.currencyAssetPressed), name: .currencyAssetPressed, object: nil)
        
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [containerStackView, assetsCotainerView])
        containerStackView.addArrangedSubviews(with: [pressentAssetsView, receiveAndBandwidthView])

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        scrollView.insertSubview(refreshControl, at: 0)
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview()
        }
//        pressentAssetsView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(25)
//            make.width.equalToSuperview()
//        }
//
//        receiveAndBandwidthView.snp.makeConstraints { make in
//            make.top.equalTo(pressentAssetsView.snp.bottom)
//            make.width.equalToSuperview()
//        }
        
        assetsCotainerView.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setData() {
        assetsCotainerView.setData(with: viewModel.currencies, and: viewModel.shouldHideData)
        pressentAssetsView.setData(with: viewModel.totalRatioBalanceForDisplay, and: viewModel.shouldHideData)
        receiveAndBandwidthView.isHidden = self.viewModel.shouldHideRecentTransaction
        receiveAndBandwidthView.setData(with: self.viewModel.recentTransactionModel)
    }
    
    @objc private func currencyAssetPressed(notification: NSNotification){
        guard let currencyModel = notification.object as? CurrencyModel else { return }
        self.navigationController?.pushViewController(CurrencyDetailsViewController(with: CurrencyDetailsViewModel(with: currencyModel)), animated: true)
    }
    
    @objc func onRefresh() {
        self.refreshData(shouldDisplaySpinner: true)
    }
}

extension CurrencyViewController {
    
    func displayTutorialPopup() {
        let view =  TutorialViewController(with: "")
        self.present(view, animated: true)
    }
    
    func displayPopupGoToThirdParty() {
        let view =  PopUpTwoActionsViewController(text: "currency_popup_going_to_third_party_title".localized, titleLeftButton: "cancel_title".localized, titleRightButton: "yes_title".localized)
        
        view.rightPressed = {[weak self] in
            view.dismiss(animated: true)
            guard let self = self else { return }
            self.navigationController?.pushViewController(WebViewController(with: self.viewModel.baseUrlForBuy), animated: true)
        }
        
        view.leftPressed = {
            view.dismiss(animated: true)
        }
        
        self.present(view, animated: true)
    }
}
