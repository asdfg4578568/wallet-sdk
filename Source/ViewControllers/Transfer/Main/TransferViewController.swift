//
//  TransferViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 21/12/2022.
//

import UIKit
import SnapKit

public class TransferViewController: UIViewController {

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
    
    private let receivingAddressView: ReceivingAddressView = {
        let view = ReceivingAddressView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let transferAmountView: TransferAmountView
    
    private lazy var minersFeesView: MinersFeesView = {
        let view = MinersFeesView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_next_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    private var viewModel: TransferViewModel
    public init(with viewModel: TransferViewModel) {
        self.viewModel = viewModel
        self.transferAmountView = TransferAmountView(with: viewModel.currencyModel.asset)
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        setData()
    }
    
    deinit {
        print("dinit.....transfer")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        addCustomBackButtonForXlink()
        view.backgroundColor = .wWhite
        super.viewDidLoad()
        title = "\(viewModel.currencyModel.asset.name) \("currency_details_transfer".localized)"
        viewModel.getGas {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_): break
            case .failure(_): break
            }
        }
        
        viewModel.getCoinRatio {[weak self] result in
            guard let self = self else { return }
            switch result {
            case true: break
            case false: break
            }
        }
    }

    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        switch viewModel.currencyModel.asset {
        case .usdtTrc20, .trx:
            containerView.addSubviews(with: [receivingAddressView, transferAmountView, nextButton])
        default:
            containerView.addSubviews(with: [receivingAddressView, transferAmountView, minersFeesView, nextButton])
           
            minersFeesView.didNotePressed = {[weak self] data in
                guard let self = self else { return }
                let view = PopUpActionWithIconViewController(text: "popup_miner_fee_estimated".localized, titleButton: "other_got_it".localized, iconName: "fees_popup_icon")
                
                view.didTapPressed = {
                    
                }
                self.present(view, animated: true)
            }
            
            minersFeesView.didSetFeesPressed = { [weak self] data in
                guard let self = self else { return }
                let setGasFeeVC = SetGasFeeViewController(with: SetGasFeeViewModel(with: self.viewModel))
                setGasFeeVC.didFeesPriorityPressed = { [weak self] index in
                    guard let self = self else { return }
                    self.viewModel.getEstimaedFee(index: index, completionHandler: {_ in })
                }
                self.navigationController?.pushViewController(setGasFeeVC, animated: true)
            }
            
            minersFeesView.didFeesRefreshed = { [weak self] data in
                guard let self = self else { return }
                self.viewModel.getGas {[weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(_):
                        self.minersFeesView.timerStart()
                    case .failure(_):
                        self.showToast(with: "something_wrong_try_again".localized)
                        self.minersFeesView.timerStart()
                    }
                }
                /*
                self.viewModel.getEstimaedFee(index: self.viewModel.gasFeesSelectedIndex, comeFromRefreshed: true, completionHandler: { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(_):
                        self.minersFeesView.timerStart()
                    case .failure(_):
                        self.showToast(with: "something_wrong_try_again".localized)
                        self.minersFeesView.timerStart()
                    }
                })
                 */
            }
        }
        nextButton.corner(cornerRadius: 28)
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        receivingAddressView.updateAddressTextField(with: viewModel.addressTo ?? "")
        
        receivingAddressView.didAddressPressed = {[weak self] data in
            guard let self = self else { return }
            let addressListVC = AddressListViewController(with: AddressListViewModel(with: self.viewModel.currencyModel))
            addressListVC.didAddressSelected = {[weak self] address in
                self?.viewModel.addressTo = address
                self?.receivingAddressView.updateAddressTextField(with: address)
            }
            self.navigationController?.pushViewController(addressListVC, animated: true)
            
        }
        
        receivingAddressView.didScanPressed = {[weak self] in
            guard let self = self else { return }
            let scanQRCodeVC = ScanQRCodeViewController()
            scanQRCodeVC.didScanFinished = {[weak self] code in
                self?.viewModel.addressTo = code
                self?.receivingAddressView.updateAddressTextField(with: code)
                scanQRCodeVC.navigationController?.dismiss(animated: true)
            }
            scanQRCodeVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(scanQRCodeVC, animated: true)
            
        }
        
        
        
        transferAmountView.didEnter = {[weak self] balanceType in
            guard let self = self else { return }
            self.viewModel.updatedBalance(with: balanceType)
        }
        
        viewModel.didUpdateBalanceFinished = {[weak self] isUpdated in
            guard let self = self else { return }
            if isUpdated {
                self.setData()
            }
        }
        
        receivingAddressView.didEnterAddress = {[weak self] address in
            guard let self = self else { return }
            self.viewModel.addressTo = address
        }
        
        viewModel.didFinishedGetEstimatedFees = {[weak self] isSuccess in
            guard let self = self else { return }
            
            switch self.viewModel.currencyModel.asset {
            case .trx, .usdtTrc20: break
            default:
                self.minersFeesView.setData(with: self.viewModel.estimatedFeesForDisplay,
                                            and: self.viewModel.estimatedNormalCurrencyFeesForDisplay,
                                            asset: self.viewModel.currencyModel.asset)
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
        
        receivingAddressView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        transferAmountView.snp.makeConstraints { make in
            make.top.equalTo(receivingAddressView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        switch viewModel.currencyModel.asset {
        case .usdtTrc20, .trx:
        
            nextButton.snp.makeConstraints { make in
                make.top.greaterThanOrEqualTo(transferAmountView.snp.bottom).offset(75)
                make.leading.equalToSuperview().offset(25)
                make.trailing.equalToSuperview().offset(-25)
                make.bottom.equalToSuperview()
                make.height.equalTo(55)
            }
        default:
            minersFeesView.snp.makeConstraints { make in
                make.top.equalTo(transferAmountView.snp.bottom).offset(30)
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
            }
            
            nextButton.snp.makeConstraints { make in
                make.top.greaterThanOrEqualTo(minersFeesView.snp.bottom).offset(75)
                make.leading.equalToSuperview().offset(25)
                make.trailing.equalToSuperview().offset(-25)
                make.bottom.equalToSuperview()
                make.height.equalTo(55)
            }
        }
        
    }
    
    private func setData() {
        receivingAddressView.setData(currencyModel: viewModel.currencyModel)
        transferAmountView.updateUI(with: viewModel.totalBalance, balanceToSend: viewModel.balanceToSend, currencyBalance: viewModel.normalCurrencyBalance)
       
        switch viewModel.currencyModel.asset {
        case .trx, .usdtTrc20:  break
        default:
            minersFeesView.setData(with: self.viewModel.estimatedFeesForDisplay,
                                        and: self.viewModel.estimatedNormalCurrencyFeesForDisplay,
                                        asset: self.viewModel.currencyModel.asset)
            minersFeesView.isHidden = viewModel.shouldHideMinersFees
        }
        
        
    }
    
    @objc private func nextPressed() {
        
        self.viewModel.validating { [weak self] status, messageType in
            guard let self = self else { return }
            switch status {
            case true:
                let paymentDetailsVC = PaymentDetailsViewController(with: PaymentDetailsViewModel(with: self.viewModel.generatePaymentModel()))
                paymentDetailsVC.didTapNextPressed = {[weak self] in
                    guard let self = self else { return }
                    
                    let enterPinCodeVC = EnterYourPinCodeViewController(viewModel: EnterYourPinCodeViewModel())
                    self.navigationController?.pushViewController(enterPinCodeVC, animated: true)

                    enterPinCodeVC.didCompleted = {[weak self] in
                        guard let self = self else { return }
                        Spinner.start()
                        self.viewModel.addNewtransfer { [weak self] status, message in
                            guard let self = self else { return }
                            Spinner.stop()
                            switch status {
                            case true:
                                self.navigationController?.pushViewController(RecentRecordsDetailsViewController(with: RecentRecordsDetailsViewModel(with: self.viewModel.currencyModel, and: message)), animated: true)
                                
                                // This is related to xlink, to create transaction type message
                                let info = ["transactionHash": message, "amount": self.viewModel.balanceToSend, "coinType": self.viewModel.currencyModel.coinType] as [String : Any]
                                NotificationCenter.default.post(name: Notification.Name("createNewTransaction"), object: nil, userInfo: info)
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                    self.navigationController?.removeViewController([TransferViewController.self, EnterYourPinCodeViewController.self])
                                })
                                
                            case false:
                                self.navigationController?.popViewController(animated: true)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                    
                                    let view =  PopUpTwoActionsViewController(text: message, titleLeftButton: "", titleRightButton: "other_got_it".localized, shouldHideLeftButton: true)
                                    
                                    view.rightPressed = {[weak self] in
                                        view.dismiss(animated: true)
                                    }
                                    self.present(view, animated: true)
                                   
                                })
                               
                                print("Please try again...")
                            }
                        }
                    }
                }
                self.navigationController?.present(paymentDetailsVC, animated: true)
                
            case false:
                
                switch messageType {
                case .lessThanTransaction(_, _):
                    let view =  PopUpTwoActionsViewController(text: messageType.description, titleLeftButton: "", titleRightButton: "other_got_it".localized, shouldHideLeftButton: true)
                    
                    view.rightPressed = { view.dismiss(animated: true) }
                    self.present(view, animated: true)
                    
                default:
                    self.showToast(with: messageType.description)
                }
                
            }
        }
    }
}
