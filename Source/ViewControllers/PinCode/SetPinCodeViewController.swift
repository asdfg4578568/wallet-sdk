//
//  SetPinCodeViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/01/2023.
//

import UIKit
import SnapKit

class SetPinCodeViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    private let enterPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "pin_enter_password_again".localized
        label.textAlignment = .center
        label.font = .font(name: .semiBold, and: 16)
        label.isHidden = true
        return label
    }()
    
    private let codeTextField: CodeTextField = {
        let codeTextField = CodeTextField()
        codeTextField.keyboardType = .decimalPad
        return codeTextField
    }()
    
    private let containerBlueView: UIView = {
        let view = UIView()
        view.backgroundColor = .wLightLightBlue.withAlphaComponent(0.1)
        return view
    }()
    
    private let wrongPasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .font(name: .regular, and: 14)
        label.textColor = .wRedE01
        label.isHidden = true
        label.text = "pin_code_are_not_the_same_set".localized
        return label
    }()
    
    private let blueLabel: UILabel = {
        let label = UILabel()
        label.text = "pin_password_are_used_for_confirm_transactions".localized
        label.textColor = .wBlue_2BC
        label.font = .font(name: .semiBold, and: 14)
        label.textAlignment = .center
        return label
    }()
    
    let viewModel: SetPinCodeViewModel
    init(with viewModel: SetPinCodeViewModel = SetPinCodeViewModel(with: .dontTakeScreenShot)) {
        self.viewModel = viewModel
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.codeTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.codeTextField.resignFirstResponder()
    }
    
    func setupViews() {
        title = "pin_set_pin_code".localized
        view.addSubview(containerView)
        containerView.addSubviews(with: [containerStackView, containerBlueView])
        containerStackView.addArrangedSubviews(with: [enterPasswordLabel, codeTextField, wrongPasswordLabel])
        containerBlueView.addSubview(blueLabel)
        customizeTextField()

        containerStackView.setCustomSpacing(5.0, after: codeTextField)

        viewModel.didTapNextStep = { [weak self]
            step in
            guard let self = self else { return }
            switch step {
            case .setPin: break
            case .confirm:
                self.enterPasswordLabel.isHidden = false
                self.codeTextField.text = ""
                self.codeTextField.refreshUI()
            }
        }
        
        codeTextField.isSecureTextEntry = true
        codeTextField.textChangeHandler = {[weak self] text, completed in
            guard let self = self else { return }
            
            if self.codeTextField.digitBorderColor != .wGray {
                self.codeTextField.digitBorderColor = .wGray
                self.codeTextField.digitBorderColorFocused = .wBlue_49B
                self.codeTextField.refreshUI()
            }
            
            if completed {
                switch self.viewModel.step {
                case .setPin:
                    self.viewModel.step = .confirm
                    self.viewModel.pinCode = text ?? ""
                case .confirm:
                    if self.viewModel.pinCode.contains(text ?? "") {
                        SDKManager.shared.pinCode = self.viewModel.pinCode
                        self.wrongPasswordLabel.isHidden = true
                        self.output()
                    } else { // Confirm pin code it's not the same...
                        self.codeTextField.digitBorderColor = .wRedE01
                        self.codeTextField.digitBorderColorFocused = .wRedE01
                        self.codeTextField.refreshUI()
                        self.wrongPasswordLabel.isHidden = false
                        print("confirm pin code it's not the same...")
                    }
                }
            }
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.lessThanOrEqualTo(130)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        wrongPasswordLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        containerBlueView.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom).offset(25)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(57)
        }
        
        blueLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func customizeTextField() {
        self.codeTextField.count = 6
        self.codeTextField.placeholder = ""
        self.codeTextField.refreshUI()
    }
    
    private func output() {
        switch viewModel.nextScreen {
        case .dontTakeScreenShot:
            self.navigationController?.pushViewController(BackupSecondNoticeViewController(with: BackupSecondNoticeViewModel(with: .BackUpMnemonicPhrase)), animated: true)
        case .enterPhrase:
            self.navigationController?.pushViewController(RecoveryPhrasesViewController(with: RecoveryPhrasesViewModel()), animated: true)
        }

    }
}
