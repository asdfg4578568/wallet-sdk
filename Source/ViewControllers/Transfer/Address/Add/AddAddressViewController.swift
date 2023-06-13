//
//  AddAddressViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import UIKit
import SnapKit

class AddAddressViewController: UIViewController {

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
    
    private let containerForAllAddressInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let containerAddAddressStackView: UIStackView = {
        let stachView = UIStackView()
        stachView.backgroundColor = .clear
        stachView.axis = .vertical
        stachView.spacing = 25
        return stachView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_save_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    private let containerNameInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let nameTitleLabel: UILabel = {
        let label = UILabel()
        //label.text = "*Name"
        label.textColor = .wWLightBlack
        label.font = .font(name: .semiBold, and: 16)
        label.textColorChange(fullText: "*\("other_name_title".localized)", changeText: "*", color: .wRedE01, font: .font(name: .semiBold, and: 16))
        label.textAlignment = .left
        return label
    }()
    
    private let containerforNameTextFiledView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = "address_less_than_words_title".localized
        textField.tag = AddAddressViewModel.TextFieldOrder.name.rawValue
        return textField
    }()
    
    private let containerAddressInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let addressTitleLabel: UILabel = {
        let label = UILabel()
        //label.text = "*Address"
        label.textColor = .wWLightBlack
        label.font = .font(name: .semiBold, and: 16)
        label.textColorChange(fullText: "*\("other_address_title".localized)", changeText: "*", color: .wRedE01, font: .font(name: .semiBold, and: 16))
        label.textAlignment = .left
        return label
    }()
    
    private let containerforAddressTextFiledView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let scanAddressButton: CircleButton = {
        let button = CircleButton()
        button.setData(with: .wWLightLightGray, and: "black_scan_icon")
        return button
    }()
    
    private let addressTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.spellCheckingType = .no
        textField.autocorrectionType = .no
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.placeholder = "address_enter_the_address".localized
        textField.tag = AddAddressViewModel.TextFieldOrder.address.rawValue
        return textField
    }()
    
    var viewModel: AddAddressViewModel
    init(with viewModel: AddAddressViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButtonForXlink()
        title = viewModel.title
        addressTextField.delegate = self
        nameTextField.delegate = self
        containerForAllAddressInfoView.backgroundColor = .wBlueE6E
        containerForAllAddressInfoView.corner()
        containerForAllAddressInfoView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
        containerforNameTextFiledView.addGradientLayer(with: [UIColor.wWLightLightGray.cgColor, UIColor.wWhite.cgColor])
        containerforNameTextFiledView.corner(borderWidth: 2, borderColor: .wWhite)
        containerforNameTextFiledView.dropShadow(with: UIColor.wWLightLightGray.cgColor, onlyBottom: false)
        
        containerforAddressTextFiledView.addGradientLayer(with: [UIColor.wWLightLightGray.cgColor, UIColor.wWhite.cgColor])
        containerforAddressTextFiledView.corner(borderWidth: 2, borderColor: .wWhite)
        containerforAddressTextFiledView.dropShadow(with: UIColor.wWLightLightGray.cgColor, onlyBottom: false)
        
        saveButton.corner(cornerRadius: 28)
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        
        viewModel.enablSavePressed = {[weak self] enabled in
            self?.updateUIForSaveButton(with: enabled)
        }
        
        scanAddressButton.pressed = {[weak self] in
            guard let self = self else { return }
            let scanQRCodeVC = ScanQRCodeViewController()
            scanQRCodeVC.didScanFinished = {[weak self] address in
                self?.addressTextField.text = address
                self?.viewModel.update(with: address, type: .address)
                scanQRCodeVC.navigationController?.dismiss(animated: true)
            }
            scanQRCodeVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(scanQRCodeVC, animated: true)
        }
    }
    
    func setupViews() {
        view.backgroundColor = .wWhite
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [containerForAllAddressInfoView, saveButton])
        containerForAllAddressInfoView.addSubview(containerAddAddressStackView)
       
        containerAddAddressStackView.addArrangedSubviews(with: [containerNameInfoView, containerAddressInfoView])
        containerNameInfoView.addSubviews(with: [nameTitleLabel, containerforNameTextFiledView])
        containerforNameTextFiledView.addSubview(nameTextField)
        containerAddressInfoView.addSubviews(with: [addressTitleLabel, containerforAddressTextFiledView])
        containerforAddressTextFiledView.addSubviews(with: [addressTextField, scanAddressButton])
        updateUIForSaveButton(with: false)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        containerForAllAddressInfoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(227)
        }
        
        containerAddAddressStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        nameTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        containerforNameTextFiledView.snp.makeConstraints { make in
            make.top.equalTo(nameTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(55)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addressTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        containerforAddressTextFiledView.snp.makeConstraints { make in
            make.top.equalTo(addressTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(55)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scanAddressButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(addressTextField.snp.trailing).offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(addressTextField)
            make.height.width.equalTo(30)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(containerForAllAddressInfoView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(55)
        }
    }
    
    func setData() {
        self.addressTextField.text = self.viewModel.address
    }
    
    private func updateUIForSaveButton(with enabled: Bool) {
        saveButton.isEnabled = enabled
        saveButton.backgroundColor = saveButton.isEnabled ? .wLightLightBlue : .wLightLightBlue.withAlphaComponent(0.3)
    }
    
    @objc private func savePressed() {
        viewModel.addAddress {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if data { self.navigationController?.popViewController(animated: true) }
                else { showAler(with: "something_wrong_try_again".localized) }
            case .failure(let error):
                switch error {
                case .other(let meesage):
                    showAler(with: meesage.customLocalizedErrorMessage)
                default:
                    showAler(with: "something_wrong_try_again".localized)
                }                
                print("error addAddress...\(error)")
            }
        }
        
        func showAler(with message: String) {
            let view =  PopUpTwoActionsViewController(text: message, titleLeftButton: "", titleRightButton: "other_got_it".localized, shouldHideLeftButton: true)
            
            view.rightPressed = {[weak self] in
                view.dismiss(animated: true)
            }
            self.present(view, animated: true)
        }
    }
}

extension AddAddressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { true }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numberOfCharacter = textField.tag == AddAddressViewModel.TextFieldOrder.name.rawValue ? 20 : 42
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        viewModel.update(with: newString, type: AddAddressViewModel.TextFieldOrder(rawValue: textField.tag) ?? .name)
        return range.location < numberOfCharacter
    }
}
