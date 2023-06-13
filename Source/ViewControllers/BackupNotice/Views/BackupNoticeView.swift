//
//  BackupNoticeView.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/12/2022.
//

import UIKit
import SnapKit

class BackupNoticeView: UIView {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()

    private let titleAndSubtitleView: TitleAndSubtitleVerticalView = {
        let view = TitleAndSubtitleVerticalView(
            forTitle: (font: UIFont.font(name: .semiBold, and: 16), color: .wLightLightBlue),
            forSubtitle: (font: UIFont.font(name: .regular, and: 14), color: .wWLightBlack))
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let circleButton: CircleButton = {
        let circleButton = CircleButton()
        return circleButton
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [circleButton, titleAndSubtitleView])
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        circleButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.width.equalTo(42)
        }
        
        titleAndSubtitleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(3)
            make.leading.equalTo(circleButton.snp.trailing).offset(20)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setData(title: String, subtitle: String, circleColor: UIColor, circleIconName: String) {
        titleAndSubtitleView.setData(with: title, and: subtitle)
        circleButton.setData(with: circleColor, and: circleIconName)
    }
}
