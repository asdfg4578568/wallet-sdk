//
//  PaymentDetailsViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 28/12/2022.
//

import UIKit

class PaymentDetailsViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .wWhite
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "transfer_payment_details_title".localized
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        label.textAlignment = .center
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage("close_black_white_icon".imageByName, for: .normal)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_next_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    private let paymentInfoView: PaymentInfoView
    private let assestCardView: CurrencyAssetCardView

    var didTapClosePressed: () -> Void = {}
    var didTapNextPressed: () -> Void = {}

    let viewModel: PaymentDetailsViewModel
    init(with viewModel: PaymentDetailsViewModel) {
        self.viewModel = viewModel
        
        self.assestCardView = CurrencyAssetCardView(with: CurrencyAssetCardModel(mainColor: .wWhite, cardColor: viewModel.paymentModel.asset.cardBackgroundColor, assetName: viewModel.paymentModel.asset.name, assetIconBackgroundColor: viewModel.paymentModel.asset.cardIconBackgroundColor, assetIconName: viewModel.paymentModel.asset.iconName, assetAmount: "\(viewModel.paymentModel.balance.descriptionFor8Digits)"))
        
        self.paymentInfoView = PaymentInfoView(with: viewModel.arrayOfPaymentInfo, currencyAssets: viewModel.paymentModel.asset)
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .wBlack.withAlphaComponent(0.5)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        scrollView.corner(cornerRadius: 12)
        containerView.corner(cornerRadius: 12)
        nextButton.corner(cornerRadius: 28)
        scrollView.backgroundColor = .white
        containerView.backgroundColor = .white
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, closeButton, assestCardView, paymentInfoView, nextButton])
        closeButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)

    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(558)
        }
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(scrollView.snp.height)
            make.width.equalTo(scrollView.snp.width)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-18)
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(24)
        }
        
        assestCardView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(110)
        }
        
        paymentInfoView.snp.makeConstraints { make in
            make.top.equalTo(assestCardView.snp.bottom)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.greaterThanOrEqualTo(268)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(paymentInfoView.snp.bottom).offset(33)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-60)
            make.height.equalTo(55)
        }
    }
    
    @objc private func closePressed() {
        dismiss(animated: true)
    }
    
    @objc private func nextPressed() {
        dismiss(animated: true, completion: {[weak self] in
            self?.didTapNextPressed()
        })
       
    }
}
