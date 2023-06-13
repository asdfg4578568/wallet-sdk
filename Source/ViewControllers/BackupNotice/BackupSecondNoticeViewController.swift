//
//  BackupSecondNoticeViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 15/12/2022.
//

import UIKit
import SnapKit

class BackupSecondNoticeViewController: DisabledSwipeNavigation {

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
    
    private let circleButton: CircleButton = {
        let circleButton = CircleButton()
        return circleButton
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let showMnemonicButton: UIButton = {
        let button = UIButton()
        button.setTitle("backup_show_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    let viewModel: BackupSecondNoticeViewModel
    init(with viewModel: BackupSecondNoticeViewModel) {
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
        
        title = viewModel.nextBackupFlow == .BackUpMnemonicPhrase ? "backup_phrase_title".localized : "backup_private_key_title".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !viewModel.nextBackupFlow.shouldHideBackButton { addCustomBackButtonForXlink() }
        navigationItem.hidesBackButton = viewModel.nextBackupFlow.shouldHideBackButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [circleButton, titleLabel, showMnemonicButton])
        showMnemonicButton.corner(cornerRadius: 28)
        showMnemonicButton.addTarget(self, action: #selector(showMnemonicPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        circleButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(112)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(circleButton.snp.bottom).offset(25)
            make.leading.equalTo(50)
            make.trailing.equalTo(-50)
        }
        
        showMnemonicButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(100)
            make.leading.equalTo(35)
            make.trailing.equalTo(-35)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(55)
        }
        
    }
    
    func setData() {
        titleLabel.text = viewModel.nextBackupFlow.text
        circleButton.setData(with: .wLightLightSkyBlue, and: "no_screenshot_icon")
    }
    
    @objc private func showMnemonicPressed() {
        
        switch viewModel.nextBackupFlow {
        case .BackUpMnemonicPhrase:
            self.navigationController?.pushViewController(BackUpMnemonicPhraseViewController(with: BackUpMnemonicPhraseViewModel()), animated: true)
        case .DisplayPrivateKey:
            self.navigationController?.pushViewController(ChoosePrivateKeyViewController(with: ChoosePrivateKeyViewModel()), animated: true)
            
        }
       
    }
}
