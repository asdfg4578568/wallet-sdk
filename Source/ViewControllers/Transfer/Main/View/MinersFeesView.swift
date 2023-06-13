//
//  MinersFeesView.swift
//  WalletSDK
//
//  Created by ashahrouj on 26/12/2022.
//

import UIKit
import SnapKit

class MinersFeesView: UIView {

    enum ScreenName {
        case transfer
        case setGasFee
    }
    
    var didNotePressed: (Bool) -> Void = {_ in }
    var didSetFeesPressed: (Bool) -> Void = {_ in }

    var timer = TimerHelper()
    var didFeesRefreshed: (Bool) -> Void = {_ in }

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "transfer_payment_miner_fee_title".localized
        label.font = UIFont.font(name: .semiBold, and: 16)
        return label
    }()

    private let noteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage("exclamation_mark_icon".imageByName, for: .normal)
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        //button.setTitle("Refresh in 7", for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.textAlignment = .right
        return button
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .wLightLightBlue
        indicatorView.isHidden = true
        return indicatorView
    }()
    
    private let containerForFessView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let seeMoreGasFeesButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage("see_fees_list_arrow_icon".imageByName, for: .normal)
        return button
    }()
    
    private let containerForLabelFessStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    private let feesTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 16)
        label.textColor = .wWLightBlack
        label.textAlignment = .left
        return label
    }()
    
    private let feesSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(name: .regular, and: 14)
        label.textColor = .wWLightBlack
        label.textAlignment = .left
        return label
    }()
    
    private var screenName: ScreenName
    init(with screenName: ScreenName = .transfer) {
        self.screenName = screenName
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        timerStart()
    }
    
    deinit {
        print("dinit.....fees")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        containerForFessView.backgroundColor = .wBlueE6E
        containerForFessView.corner()
        containerForFessView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
    }
    
    func setupViews() {
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, noteButton, refreshButton, indicatorView, containerForFessView])
        containerForFessView.addSubviews(with: [containerForLabelFessStackView, seeMoreGasFeesButton])
        containerForLabelFessStackView.addArrangedSubviews(with: [feesTitleLabel, feesSubtitleLabel])
        noteButton.addTarget(self, action: #selector(notePressed), for: .touchUpInside)
        seeMoreGasFeesButton.addTarget(self, action: #selector(gasFeesPressed), for: .touchUpInside)
        seeMoreGasFeesButton.isHidden = screenName == .setGasFee
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        noteButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(5)
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(20)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.greaterThanOrEqualToSuperview() //make.leading.greaterThanOrEqualTo(noteButton.snp.trailing).offset(5)
            make.centerY.equalTo(titleLabel)
            make.height.equalTo(20)
        }
        
        indicatorView.snp.makeConstraints { make in
            //make.leading.equalTo(refreshButton.snp.trailing).offset(5)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleLabel)
            make.height.width.equalTo(20)
        }
        
        containerForFessView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(88)
            make.bottom.equalToSuperview()
        }
        
        containerForLabelFessStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        seeMoreGasFeesButton.snp.makeConstraints { make in
            make.centerY.equalTo(containerForLabelFessStackView)
            make.trailing.equalToSuperview().offset(-20)
            make.height.width.equalTo(32)
        }
    }
    
    func setData(with estimatedFees: String, and estimatedNormalCurrencyFees: String, asset: CurrencyAssetsEnum) {
        feesTitleLabel.textColorChange(fullText: "\("miner_estimated_fee_title".localized) \(estimatedNormalCurrencyFees)", changeText: "\(estimatedNormalCurrencyFees)", color: .wWLightBlack, font: .font(name: .semiBold, and: 16))

        let name = asset.nameOnlyForTransfer
        feesSubtitleLabel.textColorChange(fullText: "\(estimatedFees)", changeText: "\(name)", color: .wWLightBlack, font: .font(name: .semiBold, and: 14))

    }
    
    @objc private func notePressed() {
        didNotePressed(true)
    }
    
    @objc private func gasFeesPressed() {
        didSetFeesPressed(true)
    }
    
    func timerStart() {
        indicatorView.isHidden = true
        indicatorView.stopAnimating()
        refreshButton.setTitle(String(format: "miner_estimated_refresh_in".localized, 14), for: .normal)
        timer.start(withTimeInterval: 1) { [weak self] counter in
            guard let self = self else { return }
            UIView.animate(withDuration: 0, delay: 0) {
                let shouldDisplayIndicator: Bool = counter == 0
                self.refreshButton.isHidden = shouldDisplayIndicator
                if shouldDisplayIndicator {
                    self.timer.stop()
                    self.indicatorView.isHidden = false
                    self.indicatorView.startAnimating()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        self.didFeesRefreshed(true)
                    })
                } else {
                    self.refreshButton.setTitle(String(format: "miner_estimated_refresh_in".localized, counter), for: .normal)
                }
            }
        }
    }
}
