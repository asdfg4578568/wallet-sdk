//
//  TitleAndSubtitleView.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/12/2022.
//

import UIKit

struct TitleAndSubtitleModel {
    let titleFont: UIFont
    let titleTextColor: UIColor
    let subtitleFont: UIFont
    let subtitleTextColor: UIColor
    let titleTextAlignment: NSTextAlignment
    let subTitleTextAlignment: NSTextAlignment
}

class TitleAndSubtitleView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    init(with model: TitleAndSubtitleModel) {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        self.titleLabel.font = model.titleFont
        self.titleLabel.textColor = model.titleTextColor
        self.titleLabel.textAlignment = model.titleTextAlignment
        self.subtitleLabel.font = model.subtitleFont
        self.subtitleLabel.textColor = model.subtitleTextColor
        self.subtitleLabel.textAlignment = model.subTitleTextAlignment
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, subtitleLabel])
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(2)
            make.trailing.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
    }
    
    func setData(with title: String, and subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
