//
//  SplashIdentityView.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/12/2022.
//

import UIKit

class SplashIdentityView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let titleAndSubtitleView: TitleAndSubtitleVerticalView = {
        let view = TitleAndSubtitleVerticalView(
            forTitle: (font: UIFont.font(name: .semiBold, and: 20), color: .wLightLightBlue),
            forSubtitle: (font: UIFont.font(name: .regular, and: 14), color: .wWLightBlack))
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = "arrow_Identity_icon".imageByName
        return imageView
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWLightDarkGray
        return view
    }()
    
    var pressed: () -> Void = {}
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        return button
    }()
    
    init(shouldHideLine: Bool = false) {
        super.init(frame: .zero)
        setupViews(with: shouldHideLine)
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(with shouldHideLine: Bool) {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubviews(with: [titleAndSubtitleView, arrowImageView, lineView, button])
        lineView.isHidden = shouldHideLine
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleAndSubtitleView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleAndSubtitleView.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(titleAndSubtitleView)
            make.height.width.equalTo(28)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleAndSubtitleView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(0.2)
        }
        
    }
    
    func setData(with title: String, and subtitle: String) {
        titleAndSubtitleView.setData(with: title, and: subtitle)
    }
    
    @objc private func buttonPressed() {
        pressed()
    }
}
