//
//  TutorialViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 29/12/2022.
//

import UIKit
import SnapKit

class TutorialViewController: UIViewController {

    private let pointerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = "tutorial_pointer_icon".imageByName
        return imageView
    }()
    
    private let containerButton: UIButton = {
        let button = UIButton()
        button.setTitle("choose_currency_from_here".localized, for: .normal)
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 18)
        button.backgroundColor = .wBlue1AB
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    init(with title: String) {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissScreen))
        view.addGestureRecognizer(tap)
        
        view.backgroundColor = .wBlack.withAlphaComponent(0.5)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        
        containerButton.backgroundColor = .wBlue1AB
        containerButton.corner()
        containerButton.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    }
    
    func setupViews() {
        view.addSubviews(with: [pointerImageView, containerButton])
    }
    
    func setupConstraints() {
        pointerImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.height.equalTo(41)
            make.width.equalTo(23.5)
        }
        
        containerButton.snp.makeConstraints { make in
            make.top.equalTo(pointerImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(68)
        }
    }
    
    @objc func dismissScreen() {
        dismiss(animated: true)
    }
}
