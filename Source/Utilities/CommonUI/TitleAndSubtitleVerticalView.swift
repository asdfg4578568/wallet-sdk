//
//  TitleAndSubtitleVerticalView.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/12/2022.
//

import UIKit

class TitleAndSubtitleVerticalView: UIView {

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    init(forTitle: (font: UIFont, color: UIColor),
         forSubtitle: (font: UIFont, color: UIColor),
         spacing: CGFloat = 0) {
        
        super.init(frame: .zero)
        setupViews(with: spacing)
        setupConstraints()
        
        titleLabel.font = forTitle.font
        titleLabel.textColor = forTitle.color

        subtitleLabel.font = forSubtitle.font        
        subtitleLabel.textColor = forSubtitle.color
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(with spacing: CGFloat = 0) {
        backgroundColor = .clear
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(subtitleLabel)
        
        containerStackView.axis = .vertical
        containerStackView.spacing = spacing
    }
    
    func setupConstraints() {
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(<#T##other: ConstraintRelatableTarget##ConstraintRelatableTarget#>)
//        }
        
    }
    
    func setData(with title: String, and subtitle: String, textAlignment: NSTextAlignment = .left) {
        titleLabel.text = title
        titleLabel.textAlignment = textAlignment
        subtitleLabel.text = subtitle
        subtitleLabel.textAlignment = textAlignment
    }

}
