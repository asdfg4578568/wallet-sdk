//
//  ChoosePrivateKeyViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 28/12/2022.
//

import UIKit
import SnapKit

class ChoosePrivateKeyViewController: UIViewController {

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
    
    /*
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose the private key format:"
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        return label
    }()
    */
    private let containerGrayView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let hexButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.setTitle("receive_hex_title".localized, for: .normal)
        //button.setImage(UIImage(named: "blue_selected_icon"), for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 18)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        //button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        return button
    }()
    /*
    private let compressedButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.setTitle("Compressed(WIF)", for: .normal)
        button.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 18)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        return button
    }()
    
    private let uncompressedButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.setTitle("Uncompressed(WIF)", for: .normal)
        button.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 18)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 13, bottom: 0, right: 0)
        return button
    }()
    */
    private let containerPrivateKeyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let privateKeyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "receive_private_key".localized
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let privateKeyValueLabel: UILabel = {
        let label = UILabel()
        label.text = "TKZKaV4sN5cFKwwGPtEmfUphfGzEML1X17"
        label.font = UIFont.font(name: .regular, and: 16)
        label.textColor = .wWLightBlack
        label.numberOfLines = 0
        return label
    }()
    
    private let copyKeyButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_copy_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    private let viewModel: ChoosePrivateKeyViewModel
    init(with viewModel: ChoosePrivateKeyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        title = "receive_display_private_key_title".localized
        view.backgroundColor = .wWhite
        super.viewDidLoad()
        getPrivateKey()
        addCustomBackButtonForXlink()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.displayDotTakeScreenshotPopup()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    func setupViews() {        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [containerGrayView, copyKeyButton])
        //containerGrayView.addSubviews(with: [titleLabel, hexButton, compressedButton, uncompressedButton, containerPrivateKeyView])
        containerGrayView.addSubviews(with: [hexButton, containerPrivateKeyView])
        containerPrivateKeyView.addSubviews(with: [privateKeyTitleLabel, privateKeyValueLabel])
        
        containerGrayView.backgroundColor = .wBlue_EAE
        containerGrayView.corner()
        containerGrayView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
        hexButton.backgroundColor = .wWhite
        hexButton.corner(borderWidth: 1, borderColor: .wWLightGray)
        hexButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
        hexButton.addTarget(self, action: #selector(formatPressed(_:)), for: .touchUpInside)

        /*
        compressedButton.backgroundColor = .wWhite
        compressedButton.corner(borderWidth: 1, borderColor: .wWLightGray)
        compressedButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
        compressedButton.addTarget(self, action: #selector(formatPressed(_:)), for: .touchUpInside)

        uncompressedButton.backgroundColor = .wWhite
        uncompressedButton.corner(borderWidth: 1, borderColor: .wWLightGray)
        uncompressedButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
        uncompressedButton.addTarget(self, action: #selector(formatPressed(_:)), for: .touchUpInside)
         */
        containerPrivateKeyView.backgroundColor = .wWhite
        containerPrivateKeyView.corner(borderWidth: 1, borderColor: .wWLightGray)
        containerPrivateKeyView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
        
        copyKeyButton.corner(cornerRadius: 28)
        copyKeyButton.addTarget(self, action: #selector(copyPressed), for: .touchUpInside)

    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        containerGrayView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(96)
        }
        /*
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(31)
        }
        */
        hexButton.snp.makeConstraints { make in
            //make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(55)
        }
        
        /*
        compressedButton.snp.makeConstraints { make in
            make.top.equalTo(hexButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(55)
        }
        
        uncompressedButton.snp.makeConstraints { make in
            make.top.equalTo(compressedButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(55)
        }
        */
        containerPrivateKeyView.snp.makeConstraints { make in
            make.top.equalTo(hexButton.snp.bottom).offset(35)
            //make.top.equalTo(uncompressedButton.snp.bottom).offset(12)
            make.leading.equalToSuperview()//.offset(15)
            make.trailing.equalToSuperview()//.offset(-15)
            make.height.greaterThanOrEqualTo(126)
        }
        
        privateKeyTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(25)
        }
        
        privateKeyValueLabel.snp.makeConstraints { make in
            make.top.equalTo(privateKeyTitleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        
        copyKeyButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(containerGrayView.snp.bottom).offset(250)
            make.leading.equalTo(35)
            make.trailing.equalTo(-35)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(55)
        }
    }
    
    @objc private func copyPressed() {
        showToast(with: "toast_copied".localized)
        UIPasteboard.general.string = self.viewModel.privateKeyString
    }
    
    @objc private func formatPressed(_ button: UIButton)  {
        let tag = button.tag
        viewModel.update(with: tag)
        getPrivateKey()
    }
    
    private func getPrivateKey() {
        viewModel.getPrivateKey { [weak self] isSuccess in
            guard let self = self else { return }
            self.updateFormatSelected(with: self.viewModel.privateKeyType.rawValue)
            self.privateKeyValueLabel.text = self.viewModel.privateKeyString
        }
    }
    
    private func updateFormatSelected(with tag: Int) {
        /*
        switch tag {
        case 1:
            hexButton.setImage(UIImage(named: "blue_selected_icon"), for: .normal)
            compressedButton.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)
            uncompressedButton.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)

        case 2:
            hexButton.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)
            compressedButton.setImage(UIImage(named: "blue_selected_icon"), for: .normal)
            uncompressedButton.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)

        case 3:
            hexButton.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)
            compressedButton.setImage(UIImage(named: "blue_unselected_icon"), for: .normal)
            uncompressedButton.setImage(UIImage(named: "blue_selected_icon"), for: .normal)
        default: break
        }
         */
    }
}

extension ChoosePrivateKeyViewController {
    
    func displayDotTakeScreenshotPopup() {
        let view =  PopUpActionWithIconViewController(text: "Please do not take screenshots to share and store, it may be collected by third-party malware and cause loss of assets", titleButton: "Got It", iconName: "don't_take_screenshot_pop_icon")
        view.didTapPressed = { }
        self.present(view, animated: true)
    }
}
