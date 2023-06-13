//
//  PaymentInfoBandWidthRowView.swift
//  WalletSDK
//
//  Created by ashahrouj on 29/12/2022.
//

import UIKit

class PaymentInfoBandWidthRowView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .wRed_FF0
        label.textAlignment = .left
        label.font = .font(name: .regular, and: 12)
        label.numberOfLines = 0
        return label
    }()
    
    private let title: String
    init(with title: String) {
        self.title = title
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        containerView.backgroundColor = .wRed_FFF
        containerView.corner()
        containerView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.1)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel])
        titleLabel.text = title
        
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
            make.trailing.equalToSuperview().offset(-6)
            make.height.equalTo(75)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.leading.equalToSuperview().offset(11)
            make.trailing.equalToSuperview().offset(-11)
            make.bottom.equalToSuperview().offset(-9)
        }
        
    }
}
