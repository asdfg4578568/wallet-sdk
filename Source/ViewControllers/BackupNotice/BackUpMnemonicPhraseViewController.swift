//
//  BackUpMnemonicPhraseViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import UIKit
import SnapKit

class BackUpMnemonicPhraseViewController: DisabledSwipeNavigation {

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
    
    private let titleTopLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        label.text = "backup_please_write_title".localized
        return label
    }()
    
    private let phrasesView: MnemonicPhrasesView
    
    private let titleFirstBottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font(name: .semiBold, and: 14)
        label.textColor = .wWLightBlack
        label.numberOfLines = 0
        label.text = "backup_keep_your_mnemonic_title".localized
        return label
    }()
    
    private let titleSecondBottomLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font(name: .semiBold, and: 14)
        label.textColor = .wWLightBlack
        label.text = "backup_dont_share_store_mnemonic_title".localized
        label.numberOfLines = 0
        return label
    }()
    
    private let notNowButton: UIButton = {
        let button = UIButton()
        button.setTitle("backup_not_title".localized, for: .normal)
        button.backgroundColor = .wWhite
        button.setTitleColor(.wSkyBlue, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    private let confirmedButton: UIButton = {
        let button = UIButton()
        button.setTitle("backup_confirmed_backup_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    private let viewModel: BackUpMnemonicPhraseViewModel
    init(with viewModel: BackUpMnemonicPhraseViewModel) {
        self.viewModel = viewModel
        self.phrasesView = MnemonicPhrasesView(with: self.viewModel.mnemonicPhrasesViewModel)
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmedButton.corner(cornerRadius: 28)
        confirmedButton.addTarget(self, action: #selector(confirmPressed), for: .touchUpInside)
        notNowButton.addTarget(self, action: #selector(notNowPressed), for: .touchUpInside)
        
        confirmedButton.isHidden = viewModel.shouldHideBottomActions
        notNowButton.isHidden = viewModel.shouldHideBottomActions
        
        viewModel.mnemonicPhrasesViewModel.didGenerated = {[weak self] data in
            DispatchQueue.main.async {
                self?.phrasesView.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: UIApplication.userDidTakeScreenshotNotification, object: nil, queue: OperationQueue.main) { [weak self] notification in
            self?.displayDotTakeScreenshotPopup()
        }
        
        if viewModel.shouldHideBottomActions { addCustomBackButtonForXlink() }
        navigationItem.hidesBackButton = !viewModel.shouldHideBottomActions
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    func setupViews() {
        title = "backup_mnemonic_phrase_title".localized
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [titleTopLabel, phrasesView, titleFirstBottomLabel, titleSecondBottomLabel, notNowButton, confirmedButton])
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        titleTopLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        phrasesView.snp.makeConstraints { make in
            make.top.equalTo(titleTopLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        titleFirstBottomLabel.snp.makeConstraints { make in
            make.top.equalTo(phrasesView.snp.bottom).offset(65)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }
        
        titleSecondBottomLabel.snp.makeConstraints { make in
            make.top.equalTo(titleFirstBottomLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
        }
        
        notNowButton.snp.makeConstraints { make in
            make.top.equalTo(titleSecondBottomLabel.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(55)
        }
        
        confirmedButton.snp.makeConstraints { make in
            make.top.equalTo(notNowButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(55)
        }
        
    }
    
    @objc private func confirmPressed() {
        self.navigationController?.pushViewController(ConfirmPhrasesViewController(with: ConfirmPhrasesViewModel()), animated: true)
    }
    
    @objc private func notNowPressed() {
        let view =  PopUpTwoActionsViewController(text: "backup_popup_you_can_check_seed_phrase_title".localized, titleLeftButton: "", titleRightButton: "backup_popup_got_it_title".localized, shouldHideLeftButton: true)
        
        view.rightPressed = {[weak self] in
            view.dismiss(animated: true)
            self?.navigationController?.pushViewController(CurrencyViewController(with: CurrencyViewModel()), animated: true)
        }
        self.present(view, animated: true)
    }
    
    private func displayDotTakeScreenshotPopup() {
        let view =  PopUpActionWithIconViewController(text: "backup_popup_please_donot_take_screenshots".localized, titleButton: "backup_popup_got_it_title".localized, iconName: "don't_take_screenshot_pop_icon")
        
        view.didTapPressed = { // Nothing to do...
        }
        self.present(view, animated: true)
    }
}
