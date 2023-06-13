//
//  ReceiveViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 21/12/2022.
//

import UIKit
import SnapKit

class ReceiveViewController: UIViewController {

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
    
    private let barcodeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .wLightLightBlue
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    private let addressButton: UIButton = {
        let button = UIButton()
        button.setTitle("TKZKaV4sN5cFKwwGPtEmfUphfGzEML1X17", for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .regular, and: 14)
        button.backgroundColor = .clear
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let copyAddressButton: UIButton = {
        let button = UIButton()
        button.setTitle("receive_copy_address".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private var viewModel: ReceiveViewModel
    init(with viewModel: ReceiveViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        addCustomBackButtonForXlink()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .wWhite
        super.viewDidLoad()
     
        let openPrivateButton = UIButton(type: .custom)
        openPrivateButton.setImage("three_dot_black_icon".imageByName, for: .normal)
        openPrivateButton.addTarget(self, action: #selector(openPrivatePressed), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: openPrivateButton)
        navigationItem.rightBarButtonItems = [item1]
        
        viewModel.getPublicAddress(with: viewModel.currencyModel.coinType) { [weak self] isSuccess in
            guard let self = self else { return }
            self.addressButton.setTitle(self.viewModel.publicAddress, for: .normal)
            self.indicatorView.startAnimating()
            DispatchQueue.global().async {
                guard let image = Helper.shared.generatingQRCodes(for: self.viewModel.publicAddress) else { return }
                DispatchQueue.main.async {
                    self.indicatorView.stopAnimating()
                    self.barcodeImageView.image = image
                }
            }
        }
    }
    
    func setupViews() {
        title = viewModel.title

        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [barcodeImageView, indicatorView, addressButton, copyAddressButton])
                
        addressButton.addGradientLayer(with: [UIColor.wMidLightGray.cgColor, UIColor.wWhite.cgColor])
        addressButton.corner(borderWidth: 1, borderColor: .wWLightGray)
        addressButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
        
        copyAddressButton.corner(cornerRadius: 28)
        copyAddressButton.addTarget(self, action: #selector(copyAddressPressed), for: .touchUpInside)
        
        
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        barcodeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.height.width.equalTo(250)
            make.centerX.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(barcodeImageView)
            make.height.width.equalTo(50)
        }
        
        addressButton.snp.makeConstraints { make in
            make.top.equalTo(barcodeImageView.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(60)
        }
        
        copyAddressButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(addressButton.snp.bottom).offset(100)
            make.leading.equalTo(35)
            make.trailing.equalTo(-35)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(55)
        }
    }
    
    @objc private func copyAddressPressed() {
        showToast(with: "toast_copied".localized)
        UIPasteboard.general.string = self.viewModel.publicAddress
    }
    
    @objc private func openPrivatePressed() {
        
        let view =  DisplayPrivateKeySheetViewController()
        
        view.didTapOn = {[weak self] nextScreen in
            guard let self = self else { return }
            
            let enterCode = EnterYourPinCodeViewController(viewModel: EnterYourPinCodeViewModel())
            enterCode.didCompleted = {[weak self] in
                guard let self = self else { return }
                switch nextScreen {
                case .displayShowPhrases:
                    self.navigationController?.pushViewController(BackUpMnemonicPhraseViewController(with: BackUpMnemonicPhraseViewModel(shouldHideBottomActions: true)), animated: true)
                case .displayPrivateKey:
                    SDKManager.shared.currencyModel = self.viewModel.currencyModel
                    self.navigationController?.pushViewController(BackupSecondNoticeViewController(with: BackupSecondNoticeViewModel(with: .DisplayPrivateKey)), animated: true)
                }
                self.navigationController?.removeViewController([EnterYourPinCodeViewController.self])
            }
            self.navigationController?.pushViewController(enterCode, animated: true)
        }
        self.present(view, animated: true)
    }
}
