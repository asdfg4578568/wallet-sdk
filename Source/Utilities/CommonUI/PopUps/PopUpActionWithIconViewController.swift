//
//  PopUpActionWithIconViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 23/12/2022.
//

import UIKit
import SnapKit

class PopUpActionWithIconViewController: UIViewController {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        return image
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
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.wLightLightBlue, for: .normal)
        button.titleLabel?.font = .font(name: .bold, and: 18)
        button.backgroundColor = .clear
        return button
    }()
    
    var didTapPressed: () -> Void = {}
    
    private let text: String
    private let titleButton: String
    private let iconName: String

    init(text: String, titleButton: String, iconName: String) {
        self.text = text
        self.titleButton = titleButton
        self.iconName = iconName
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
        button.corner(cornerRadius: 5)
    }

    func setupViews() {
        view.addSubview(containerView)
        containerView.addSubviews(with: [iconImageView, titleLabel, containerStackView])
        containerStackView.addArrangedSubviews(with: [button])
        
        containerStackView.axis = .horizontal
        containerStackView.spacing = 10
        containerStackView.distribution = .fillEqually
        containerStackView.alignment = .fill
        
        
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.greaterThanOrEqualTo(180)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.lessThanOrEqualTo(180)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(35)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    func setData() {
        button.setTitle(titleButton, for: .normal)
        titleLabel.text = text
        iconImageView.image = iconName.imageByName
    }
    
    @objc private func pressed() {
        dismiss(animated: true)
        didTapPressed()
    }
}
