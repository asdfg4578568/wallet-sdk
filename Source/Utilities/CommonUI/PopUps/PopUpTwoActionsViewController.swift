//
//  PopUpTwoActionsViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 21/12/2022.
//

import UIKit
import SnapKit

class PopUpTwoActionsViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let leftButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 15)
        button.backgroundColor = .wLightLightBlue
        return button
    }()
    
    private let rightButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.wWhite, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 15)
        button.backgroundColor = .wLightLightBlue
        return button
    }()
    
    var leftPressed: () -> Void = {}
    var rightPressed: () -> Void = {}
    
    private let text: String
    private let titleLeftButton: String
    private let titleRightButton: String
    private let shouldHideLeftButton: Bool
    
    init(text: String, titleLeftButton: String, titleRightButton: String, shouldHideLeftButton: Bool = false) {
        self.text = text
        self.titleLeftButton = titleLeftButton
        self.titleRightButton = titleRightButton
        self.shouldHideLeftButton = shouldHideLeftButton
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
        leftButton.corner(cornerRadius: 5)
        rightButton.corner(cornerRadius: 5)
    }

    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, containerStackView])
        containerStackView.addArrangedSubviews(with: [leftButton, rightButton])
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.distribution = .fillEqually
        containerStackView.alignment = .fill
        
        titleLabel.text = text
        leftButton.addTarget(self, action: #selector(leftDidPressed), for: .touchUpInside)
        leftButton.isHidden = shouldHideLeftButton
        rightButton.addTarget(self, action: #selector(rightDidPressed), for: .touchUpInside)
        rightButton.backgroundColor = shouldHideLeftButton ? .clear : .wLightLightBlue
        rightButton.setTitleColor(shouldHideLeftButton ? .wLightLightBlue : .wWhite, for: .normal)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.greaterThanOrEqualTo(166)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.lessThanOrEqualTo(166)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-25)
        }
        
    }
    
    func setData() {
        leftButton.setTitle(titleLeftButton, for: .normal)
        rightButton.setTitle(titleRightButton, for: .normal)
    }
    
    @objc private func leftDidPressed() {
        leftPressed()
    }
    
    @objc private func rightDidPressed() {
        rightPressed()
    }
}
