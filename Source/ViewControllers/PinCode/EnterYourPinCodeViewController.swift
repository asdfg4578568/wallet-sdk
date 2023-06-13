//
//  EnterYourPinCodeViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/01/2023.
//

import UIKit
import SnapKit

class EnterYourPinCodeViewController: UIViewController {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let codeTextField: CodeTextField = {
        let codeTextField = CodeTextField()
        codeTextField.keyboardType = .decimalPad
        return codeTextField
    }()
    
    private let wrongPasswordLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .font(name: .regular, and: 14)
        label.textColor = .wRedE01
        label.isHidden = true
        label.text = "pin_code_is_wrong_pls_try_again".localized
        return label
    }()
    
    private let forgetPasswordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.setTitle("pin_forgot_your_password".localized, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    var didCompleted: () -> Void = {}
    var bottomConstraint: Constraint?

    let viewModel: EnterYourPinCodeViewModel
    init(viewModel: EnterYourPinCodeViewModel) {
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
    
    func setupViews() {
        title = "pin_enter_your_pin_code".localized
        view.addSubview(containerView)
        containerView.addSubviews(with: [codeTextField, wrongPasswordLabel, forgetPasswordButton])
        customizeTextField()

        codeTextField.becomeFirstResponder()
        codeTextField.isSecureTextEntry = true
        codeTextField.textChangeHandler = {[weak self] text, completed in
            guard let self = self, let text = text else { return }
            
            if self.codeTextField.digitBorderColor != .wGray {
                self.codeTextField.digitBorderColor = .wGray
                self.codeTextField.digitBorderColorFocused = .wBlue_49B
                self.codeTextField.refreshUI()
            }
            
            if completed {
                
                self.viewModel.verifyPasscode(with: text) { [weak self] isSuccess in
                    guard let self = self else { return }
                    if isSuccess {
                        SDKManager.shared.pinCode = text
                        self.wrongPasswordLabel.isHidden = true
                        self.didCompleted()
                    } else {
                        self.codeTextField.digitBorderColor = .wRedE01
                        self.codeTextField.digitBorderColorFocused = .wRedE01
                        self.codeTextField.refreshUI()
                        self.wrongPasswordLabel.isHidden = false
                    }
                }
            }
        }
        forgetPasswordButton.addTarget(self, action: #selector(forgotPasswordPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        codeTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
        
        wrongPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(30)
        }
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(wrongPasswordLabel.snp.bottom).offset(20)
            bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
    func customizeTextField() {
        self.codeTextField.count = 6
        self.codeTextField.placeholder = ""
        self.codeTextField.refreshUI()
    }
    
    @objc private func forgotPasswordPressed() {
        let view =  PopUpTwoActionsViewController(text: "pin_you_reset_pin_code_by_uninstalling".localized, titleLeftButton: "", titleRightButton: "other_got_it".localized, shouldHideLeftButton: true)
        
        view.rightPressed = {[weak self] in
            view.dismiss(animated: true)
        }
        self.present(view, animated: true)
    }
    
}

extension EnterYourPinCodeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, keyboardWillShow: true)
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        moveViewWithKeyboard(notification: notification, keyboardWillShow: false)
    }
    
    func moveViewWithKeyboard(notification: NSNotification, keyboardWillShow: Bool) {
        
        // Keyboard's size
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardSize.height
        
        // Keyboard's animation duration
        let keyboardDuration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        
        // Keyboard's animation curve
        let keyboardCurve = UIView.AnimationCurve(rawValue: notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)!
        
        let safeAreaExists = (self.view?.window?.safeAreaInsets.bottom != 0)
        bottomConstraint?.update(offset: keyboardWillShow ? -(keyboardHeight + (safeAreaExists ? -20 : 20)) : 0)
        
        
        // Animate the view the same way the keyboard animates
        let animator = UIViewPropertyAnimator(duration: keyboardDuration, curve: keyboardCurve) { [weak self] in
            // Update Constraints
            self?.view.layoutIfNeeded()
        }
        
        // Perform the animation
        animator.startAnimation()
    }
    
}
