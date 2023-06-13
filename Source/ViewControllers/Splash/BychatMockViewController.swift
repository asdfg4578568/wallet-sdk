//
//  BychatMockViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 01/02/2023.
//

import UIKit

class BychatMockViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wMidLightGray
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.placeholder = "Please enter your ID"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_next_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addCustomBackButtonForXlink()
       
    }
    
    func setupViews() {
        view.backgroundColor = .wWhite
        view.addSubview(containerView)
        containerView.addSubviews(with: [textField, enterButton])
        
        containerView.addGradientLayer(with: [UIColor.wMidLightGray.cgColor, UIColor.wWhite.cgColor])
        containerView.corner(cornerRadius: 8, borderColor: .wWhite)
        containerView.dropShadow(with: UIColor.wWLightDarkGray.cgColor, onlyBottom: true)
        
        enterButton.corner(cornerRadius: 15)
        enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(100)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(50)
        }
        
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(8)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
    }
    
    @objc private func enterPressed() {
        guard let text = textField.text, !text.isEmpty else {
            showToast(with: "Please enter your ID")
            return
        }
       
        UserDefaults.standard.set(text, forKey: DefaultsKeys.userId)
        /* TODO: i will back to this when handle the notification in the xlink or seperate project for Wallet
        JPUSHService.setAlias(text, completion: { code, msg, code2 in
            debugPrint("Alias set successfully:", code, msg ?? "no message", code2)
            print("Alias set successfully:")
        }, seq: 0)
        */
        
        SDKManager.shared.userId = text
        navigationController?.initWalletSDK()
        navigationController?.pushViewController(CryptoSplashViewController(), animated: true)
    }
}
