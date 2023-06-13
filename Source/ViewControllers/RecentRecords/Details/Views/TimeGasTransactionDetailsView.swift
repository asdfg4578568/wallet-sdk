//
//  TimeGasTransactionDetailsView.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/12/2022.
//

import UIKit
import SnapKit

class TimeGasTransactionDetailsView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let confirmTimeView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .semiBold, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .regular, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
        return view
    }()
    
    private let networkFeeView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .semiBold, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .regular, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
        return view
    }()
    
    private let containerSeeMoreView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let seeMoreView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let seeMoreArrowImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let seeMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.wSkyBlue, for: .normal)
        button.titleLabel?.font = UIFont.font(name: .semiBold, and: 12)
        button.setTitle("transfer_click_to_see_more".localized, for: .normal)
        return button
    }()
    
    private let gasPriceView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .semiBold, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .regular, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
        return view
    }()
    
    private let gasLimitView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .semiBold, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .regular, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
        return view
    }()
    
    private let gasUsedView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .semiBold, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .regular, and: 14), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
        return view
    }()
    
    private let confirmationsView: TitleAndSubtitleView = {
        let view = TitleAndSubtitleView(with: TitleAndSubtitleModel(titleFont: UIFont.font(name: .semiBold, and: 14), titleTextColor: .wWLightBlack, subtitleFont: UIFont.font(name: .regular, and: 12), subtitleTextColor: .wBlack42, titleTextAlignment: .left, subTitleTextAlignment: .right))
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        backgroundColor = .clear
        seeMoreView.backgroundColor = .wWhite
        seeMoreView.corner(cornerRadius: 12)
        seeMoreView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)

        containerView.backgroundColor = .wBlueE6E
        containerView.corner()
        containerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(containerStackView)
        containerStackView.addArrangedSubviews(with: [confirmTimeView, networkFeeView, containerSeeMoreView, gasPriceView, gasLimitView, gasUsedView, confirmationsView])
        
        containerSeeMoreView.addSubview(seeMoreView)
        seeMoreView.addSubviews(with: [seeMoreButton, seeMoreArrowImageView])
        
        containerStackView.axis = .vertical
        containerStackView.alignment = .fill
        containerStackView.distribution = .fill
        containerStackView.spacing = 5
        
        seeMoreButton.addTarget(self, action: #selector(seeMorePressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()

        }
        
        containerStackView.snp.makeConstraints { make in
                        make.top.equalToSuperview().offset(15)
                        make.leading.equalToSuperview().offset(20)
                        make.trailing.equalToSuperview().offset(-20)
                        make.bottom.equalToSuperview().offset(-15)
        }
        
        containerSeeMoreView.snp.makeConstraints { make in
            make.height.equalTo(25)
        }
        
        seeMoreView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(120)
        }
        
        seeMoreButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
        }
        
        seeMoreArrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(seeMoreButton.snp.trailing).offset(3)
            make.trailing.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(18)
        }
    }
    
    func setData(with transactionHistoryModel: TransactionHistoryModel) {
        confirmTimeView.setData(with: "transaction_details_confirm_time".localized, and: transactionHistoryModel.confirmTime)
        networkFeeView.setData(with: "transaction_details_network_fee".localized, and: "\(transactionHistoryModel.fee.descriptionFor12Digits) \(transactionHistoryModel.currencyAssetsType?.nameOnlyForTransfer ?? "")")
        gasPriceView.setData(with: "transaction_details_gas_price".localized, and: "\(transactionHistoryModel.gasPriceConv ?? "") \(transactionHistoryModel.currencyAssetsType?.nameOnlyForTransfer ?? "")")
        gasLimitView.setData(with: "transaction_details_gas_limit".localized, and: "\(transactionHistoryModel.gasLimit?.descriptionFor12Digits ?? "")")
        gasUsedView.setData(with: "transaction_details_gas_used".localized, and: "\(transactionHistoryModel.gasUsed?.descriptionFor12Digits ?? "")")
        confirmationsView.setData(with: "transaction_details_confirmations".localized, and: "\(transactionHistoryModel.confirmBlockNumber)")
        displayBottomSectionView(with: true)
        
        if transactionHistoryModel.option == .receive {
            shouldHideGasSection()
        } else if let currencyAssetsType = transactionHistoryModel.currencyAssetsType {
            if CurrencyAssetsEnum.getAssetsEnumType(by: currencyAssetsType.coinId) == .trx || CurrencyAssetsEnum.getAssetsEnumType(by: currencyAssetsType.coinId) == .usdtTrc20 {
                shouldHideGasSection()
                confirmationsView.isHidden = false
            }
        }
    }
    
    @objc private func seeMorePressed() {
        let shouldSeeMore: Bool = !gasPriceView.isHidden
        let title = shouldSeeMore ? "transfer_click_to_see_more".localized : "transfer_click_to_see_less".localized
        displayBottomSectionView(with: shouldSeeMore)
        seeMoreButton.setTitle(title, for: .normal)
    }
    
    private func displayBottomSectionView(with shouldSeeMore: Bool) {
        gasPriceView.isHidden = shouldSeeMore
        gasLimitView.isHidden = shouldSeeMore
        gasUsedView.isHidden = shouldSeeMore
        confirmationsView.isHidden = shouldSeeMore
        
        let iconName = shouldSeeMore ? "see_more_arrow_icon" : "see_less_arrow_icon"
        seeMoreArrowImageView.image = iconName.imageByName
    }
    
    private func shouldHideGasSection() {
        gasPriceView.isHidden = true
        gasLimitView.isHidden = true
        gasUsedView.isHidden = true
        confirmationsView.isHidden = true
        seeMoreView.isHidden = true
        seeMoreArrowImageView.isHidden = true
        containerSeeMoreView.isHidden = true
    }
}
