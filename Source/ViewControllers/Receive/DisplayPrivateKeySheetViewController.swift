//
//  DisplayPrivateKeySheetViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 28/12/2022.
//

import UIKit
import SnapKit

class DisplayPrivateKeySheetViewController: UIViewController {
    
    enum NextScreen {
        case displayPrivateKey
        case displayShowPhrases
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let displayPrivateKeyButton: UIButton = {
        let button = UIButton()
        button.setTitle("receive_display_private_key".localized, for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 14)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 0)
        return button
    }()
    
    private let displaySeedPhraseButton: UIButton = {
        let button = UIButton()
        button.setTitle("receive_show_seed_phrase".localized, for: .normal)
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 14)
        button.backgroundColor = .clear
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 0)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_close_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    
    var didTapOn: (NextScreen) -> Void = { _ in }

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
        view.backgroundColor = .wBlack.withAlphaComponent(0.5)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        containerView.corner(cornerRadius: 12)
        
        displayPrivateKeyButton.backgroundColor = .wBlueE6E
        displayPrivateKeyButton.corner()
        displayPrivateKeyButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
        displaySeedPhraseButton.backgroundColor = .wBlueE6E
        displaySeedPhraseButton.corner()
        displaySeedPhraseButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
        
        closeButton.corner(cornerRadius: 28)
        closeButton.addTarget(self, action: #selector(closePressed), for: .touchUpInside)
        displayPrivateKeyButton.addTarget(self, action: #selector(displayPrivateKeyPressed), for: .touchUpInside)
        displaySeedPhraseButton.addTarget(self, action: #selector(displayShowPhrasesPressed), for: .touchUpInside)

    }
    
    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubviews(with: [displayPrivateKeyButton, displaySeedPhraseButton, closeButton])
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(259)
        }
        
        displayPrivateKeyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(58)
        }
        
        displaySeedPhraseButton.snp.makeConstraints { make in
            make.top.equalTo(displayPrivateKeyButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(58)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(displaySeedPhraseButton.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-32)
            make.leading.equalToSuperview().offset(35)
            make.trailing.equalToSuperview().offset(-35)
            make.height.equalTo(55)
        }
    }
    
    func setData() {
        
    }
    
    @objc private func closePressed() {
        dismiss(animated: true)
    }
    
    @objc private func displayPrivateKeyPressed() {
        dismiss(animated: true)
        didTapOn(.displayPrivateKey)
    }
    
    @objc private func displayShowPhrasesPressed() {
        dismiss(animated: true)
        didTapOn(.displayShowPhrases)
    }
}
