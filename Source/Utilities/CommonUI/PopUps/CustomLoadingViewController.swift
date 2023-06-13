//
//  CustomLoadingViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 12/01/2023.
//

import UIKit

class CustomLoadingViewController: UIViewController {

    private let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.color = .wLightLightBlue
        return indicatorView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .wBlack.withAlphaComponent(0.5)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }

    func setupViews() {
        view.addSubview(indicatorView)
    }
    
    func setupConstraints() {
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
    }
}
