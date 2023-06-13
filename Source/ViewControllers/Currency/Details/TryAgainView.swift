//
//  TryAgainView.swift
//  WalletSDK
//
//  Created by ashahrouj on 16/01/2023.
//

import UIKit

class TryAgainView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .font(name: .regular, and: 14)
        label.text = "Something wrong"
        label.textColor = .wWLightBlack
        label.textAlignment = .center
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("other_try_again_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 12)
        return button
    }()
    
    var didTapTryAgainPressed: () -> Void = {}

    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        button.corner(cornerRadius: 5)
        button.addTarget(self, action: #selector(tryAgainPressed), for: .touchUpInside)
    }
    
    func setupViews() {
        backgroundColor = .clear
        containerView.backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, button])
    }
    
    func setupConstraints() {
       
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
    }
    
    @objc private func tryAgainPressed() {
        didTapTryAgainPressed()
    }
}
