//
//  BackupNoticeViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/12/2022.
//

import UIKit
import SnapKit

class BackupNoticeViewController: UIViewController {

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
    
    private let whatIsSeedPhrase: BackupNoticeView = {
        let view = BackupNoticeView()
        return view
    }()
    
    private let backupTheSeedPhrase: BackupNoticeView = {
        let view = BackupNoticeView()
        return view
    }()
    
    private let keepTheMnemonicsSecret: BackupNoticeView = {
        let view = BackupNoticeView()
        return view
    }()
    
    private let noticedButton: UIButton = {
        let button = UIButton()
        button.setTitle("backup_start_to_backup".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    init() {
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
        title = "backup_the_seed_phrase_title".localized
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [whatIsSeedPhrase, backupTheSeedPhrase, keepTheMnemonicsSecret, noticedButton])
        noticedButton.corner(cornerRadius: 28)
        noticedButton.addTarget(self, action: #selector(noticedPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        whatIsSeedPhrase.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        backupTheSeedPhrase.snp.makeConstraints { make in
            make.top.equalTo(whatIsSeedPhrase.snp.bottom).offset(15)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        keepTheMnemonicsSecret.snp.makeConstraints { make in
            make.top.equalTo(backupTheSeedPhrase.snp.bottom).offset(15)
            make.leading.equalTo(30)
            make.trailing.equalTo(-30)
        }
        
        noticedButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(keepTheMnemonicsSecret.snp.bottom).offset(100)
            make.leading.equalTo(35)
            make.trailing.equalTo(-35)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(55)
        }
    }
    
    func setData() {
        whatIsSeedPhrase.setData(title: "backup_what_is_seed_phrase_title".localized, subtitle: "backup_what_is_seed_phrase_subtitle".localized, circleColor: .wLightLightBlue, circleIconName: "backup_notice_what_is_seed_icon")
        
        backupTheSeedPhrase.setData(title: "backup_the_seed_phrase_title".localized, subtitle: "backup_the_seed_phrase_subtitle".localized, circleColor: .wLightLightBlue, circleIconName: "backup_notice_the_seed_icon")
        
        keepTheMnemonicsSecret.setData(title: "backup_keep_the_mnemonics_title".localized, subtitle: "backup_keep_the_mnemonics_subtitle".localized, circleColor: .wLightLightBlue, circleIconName: "backup_notice_keep_mnemoncis_icon")
        
    }
    
    @objc private func noticedPressed() {
        self.navigationController?.pushViewController(SetPinCodeViewController(), animated: true)
        // self.navigationController?.pushViewController(BackupSecondNoticeViewController(), animated: true)
        
    }
}
