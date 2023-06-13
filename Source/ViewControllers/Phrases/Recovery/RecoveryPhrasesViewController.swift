//
//  RecoveryPhrasesViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 23/12/2022.
//

import UIKit
import SnapKit

class RecoveryPhrasesViewController: UIViewController {
    
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
    
    private let phrasesSelectedView: MnemonicPhrasesSelectedView = {
        let view = MnemonicPhrasesSelectedView(with: MnemonicPhrasesSelectedViewModel())
        return view
    }()
    
    private let suggestionPhrasesView: SuggestionPhrasesView = {
        let view = SuggestionPhrasesView()
        view.isHidden = true
        return view
    }()
    
    private let containerBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .wGray8
        textField.placeholder = "phrases_please_input_your_seed".localized
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let nextButton: UIButton = {
        let nextButton = UIButton()
        nextButton.backgroundColor = .wLightLightBlue
        nextButton.setTitleColor(.wWhite, for: .normal)
        nextButton.setTitle("other_next_title".localized, for: .normal)
        nextButton.titleLabel?.font = .font(name: .semiBold, and: 16)
        nextButton.isEnabled = false
        nextButton.backgroundColor = .wLightLightBlue.withAlphaComponent(0.3)
        return nextButton
    }()
    
    var bottomConstraint: Constraint?
    
    let viewModel: RecoveryPhrasesViewModel
    init(with viewModel: RecoveryPhrasesViewModel) {
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        textField.corner(cornerRadius: 6)
        nextButton.corner(cornerRadius: 6)
        suggestionPhrasesView.corner(cornerRadius: 12)
        
        viewModel.didWordFilterd = {[weak self] phrase in
            guard let self = self else { return }
            self.suggestionPhrasesView.filtered(with: phrase)
            self.suggestionPhrasesView.isHidden = phrase.count == 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                self.nextButton.isEnabled = self.viewModel.phraseIsExist(with: self.textField.text ?? "")
                self.nextButton.backgroundColor = self.nextButton.isEnabled ? .wLightLightBlue : .wLightLightBlue.withAlphaComponent(0.3)
            })
        }
        
        viewModel.didRecoveryFinihsed = {[weak self] isFinshed in
            guard let self = self, isFinshed else { return }
            self.dismissKeyboard()
            self.navigationController?.pushViewController(CurrencyViewController(with: CurrencyViewModel()), animated: true)
        }
        
        suggestionPhrasesView.didTapOnPhrase = { [weak self] phrase in
            guard let self = self else { return }
            self.didSelected(for: phrase)
//            self.phrasesSelectedView.addPhrase(with: phrase)
//            self.viewModel.add(with: phrase)
//            //self.viewModel.remove(with: phrase).... we need this if we will not support the duplicate pharese in the 12 phrases
//            self.viewModel.checkingRecoveryIfFinihsed()
//            self.textField.text = ""
//            self.suggestionPhrasesView.clearData()
        }
        
        phrasesSelectedView.didTapRemovePressed = { [weak self] mnemonicPhrasesModel in
            guard let self = self else { return }
            self.viewModel.remove(with: mnemonicPhrasesModel)
            //self.viewModel.add(with: mnemonicPhrasesModel.phrase) .... we need this if we will not support the duplicate pharese in the 12 phrases
        }
    }
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.textField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.textField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setupViews() {
        title = "phrases_enter_your_phrase".localized
        view.addSubview(containerView)
        containerView.addSubviews(with: [scrollView, suggestionPhrasesView, containerBottomView])
        scrollView.addSubview(phrasesSelectedView)
        containerBottomView.addSubviews(with: [textField, nextButton])
        textField.delegate = self
        
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)

    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.greaterThanOrEqualTo(230)
        }
        
        phrasesSelectedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        suggestionPhrasesView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(scrollView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        containerBottomView.snp.makeConstraints { make in
            make.top.equalTo(suggestionPhrasesView.snp.bottom).offset(20)
            bottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(45)
        }
        
        textField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(85)
        }
        
        
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
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
    
    @objc private func nextPressed() {
        if self.viewModel.phrasesFilterdArray.count == 12 {
            self.navigationController?.pushViewController(CurrencyViewController(with: CurrencyViewModel()), animated: true)
            self.navigationController?.removeViewController([RecoveryPhrasesViewController.self, SetPinCodeViewController.self])
        } else if viewModel.phrasesFilterdArray.count < 12 {
            self.didSelected(for: MnemonicPhrasesModel(phrase: textField.text ?? "", isSelected: true))
        }
    }
    
    private func didSelected(for phrase: MnemonicPhrasesModel) {
        if self.viewModel.phrasesFilterdArray.count >= 12 {
            return
        }
        self.phrasesSelectedView.addPhrase(with: phrase)
        self.viewModel.add(with: phrase)
        //self.viewModel.remove(with: phrase).... we need this if we will not support the duplicate pharese in the 12 phrases
        self.viewModel.checkingRecoveryIfFinihsed()
        self.textField.text = ""
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = self.nextButton.isEnabled ? .wLightLightBlue : .wLightLightBlue.withAlphaComponent(0.3)
        self.suggestionPhrasesView.isHidden = true
        self.suggestionPhrasesView.clearData()
    }
}

extension RecoveryPhrasesViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { true }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.viewModel.filter(with: updatedText)
        return range.location < 10
    }
}
