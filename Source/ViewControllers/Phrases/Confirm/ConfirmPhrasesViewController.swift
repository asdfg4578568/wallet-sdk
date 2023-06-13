//
//  ConfirmPhrasesViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import UIKit
import SnapKit

class ConfirmPhrasesViewController: UIViewController {

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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        label.text = "phrases_please_select_mnemonic_phrase".localized
        return label
    }()
    
    private let phrasesSelectedView: MnemonicPhrasesSelectedView
    private let phrasesView: MnemonicPhrasesView
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_next_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        button.isEnabled = false
        button.backgroundColor = button.isEnabled ? .wLightLightBlue : .wLightLightBlue.withAlphaComponent(0.3)
        return button
    }()
    
    let viewModel: ConfirmPhrasesViewModel
    init(with viewModel: ConfirmPhrasesViewModel) {
        self.viewModel = viewModel
        self.phrasesView = MnemonicPhrasesView(with: viewModel.mnemonicPhrasesViewModel)
        self.phrasesSelectedView = MnemonicPhrasesSelectedView(with: viewModel.mnemonicPhrasesSelectedViewModel)
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
        nextButton.corner(cornerRadius: 28)
        nextButton.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
    }
    
    func setupViews() {
        title = "other_confirm_title".localized
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, phrasesSelectedView, phrasesView, nextButton])
        
        phrasesView.didTapPhrasePressed = { [weak self] phrase in
            guard let self = self else { return }
            self.phrasesSelectedView.addPhrase(with: phrase)
        }
        
        phrasesSelectedView.didTapRemovePressed = { [weak self] phrase in
            guard let self = self else { return }
            self.phrasesView.unSelected(phrasesModel: phrase)
        }
        
        self.viewModel.didConfirmed = {[weak self] confirmed in
            guard let self = self else { return }
            self.nextButton.isEnabled = confirmed
            self.nextButton.backgroundColor = self.nextButton.isEnabled ? .wLightLightBlue : .wLightLightBlue.withAlphaComponent(0.3)
            
            if !confirmed && self.viewModel.mnemonicPhrasesSelectedViewModel.phrasesArray.count == 12 {
                self.showToast(with: "phrases_order_wrong_try_again".localized)
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
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        phrasesSelectedView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        phrasesView.snp.makeConstraints { make in
            make.top.equalTo(phrasesSelectedView.snp.bottom).offset(25)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(phrasesView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(55)
        }
    }
    
    func setData() {
        
    }
    
    @objc private func nextPressed() {
        let view =  PopUpTwoActionsViewController(text: "backup_popup_you_can_check_seed_phrase_title".localized, titleLeftButton: "", titleRightButton: "backup_popup_got_it_title".localized, shouldHideLeftButton: true)
        
        view.rightPressed = {[weak self] in
            view.dismiss(animated: true)
            self?.navigationController?.pushViewController(CurrencyViewController(with: CurrencyViewModel()), animated: true)
        }
        self.present(view, animated: true)
    }
    
}
