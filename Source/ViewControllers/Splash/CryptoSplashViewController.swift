//
//  CryptoSplashViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 13/12/2022.
//

import UIKit
import SnapKit

public class CryptoSplashViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .wWhite
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wWhite
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage("back_for_xlink".imageByName, for: .normal)
        button.addDefaultShadowForXlink()
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font(name: .semiBold, and: 20)
        return label
    }()
    
    private let containerIdentityView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let createIdentityView: SplashIdentityView = {
        let view = SplashIdentityView()
        view.setData(with: "spalsh_create_identity_title".localized, and: "spalsh_create_identity_sub_title".localized)
        return view
    }()
    
    private let recoverIdentityView: SplashIdentityView = {
        let view = SplashIdentityView(shouldHideLine: true)
        view.setData(with: "spalsh_recover_identity_title".localized, and: "spalsh_recover_identity_sub_title".localized)
        return view
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        return stackView
    }()
    
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.font(name: .bold, and: 14)
        label.textColor = .wWLightDarkGray
        label.displayAppVersionAndBuild()
        return label
    }()
    
    private let pagerFirstView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let pagerSecondView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SplashViewViewCell.self, forCellWithReuseIdentifier: SplashViewViewCell.className)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var timer = TimerHelper.init(counter: 5)
    
    private let viewModel: SplashViewModel
    public init(with viewModel: SplashViewModel = SplashViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        containerIdentityView.corner(borderWidth: 1, borderColor: .white)
        containerIdentityView.dropShadow(with: UIColor.wDarkGray.cgColor, onlyBottom: false, shadowOpacity: 0.3)
        
        pagerFirstView.corner(cornerRadius: 2)
        pagerSecondView.corner(cornerRadius: 2)
        //addCustomBackButtonForXlink()
        backButton.addTarget(self, action: #selector(backActionForXlink(_:)), for: .touchUpInside)

    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.timerStart()
        viewModel.checkUserStatus { [weak self] data in
            guard let self = self else { return }
            switch data {
            case .success(let status):
                print("checkUserStatus \(status)")
                if status == .registered {
                    self.navigationController?.pushViewController(CurrencyViewController(with: CurrencyViewModel()), animated: true)
                }
            case .failure(let error):
                print("something wronge checkUserStatus")
            }
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.stop()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubviews(with: [backButton, titleLabel, collectionView, containerIdentityView, versionLabel, containerStackView])
        containerIdentityView.addSubviews(with: [createIdentityView, recoverIdentityView])
        containerStackView.addArrangedSubviews(with: [pagerFirstView, pagerSecondView])
        createIdentityView.pressed = {
            self.navigationController?.pushViewController(BackupNoticeViewController(), animated: true)
            /*
            let view =  PopUpTwoActionsViewController(text: "spalsh_popup_you_have_already_created_wallet_account".localized, titleLeftButton: "cancel_title".localized, titleRightButton: "yes_title".localized)
            
            view.rightPressed = {[weak self] in
                view.dismiss(animated: true)
                self?.navigationController?.pushViewController(BackupNoticeViewController(), animated: true)
            }
            
            view.leftPressed = {
                view.dismiss(animated: true)
            }
            
            self.present(view, animated: true)
             */
        }
        
        recoverIdentityView.pressed = {
            
            self.navigationController?.pushViewController(SetPinCodeViewController(with: SetPinCodeViewModel(with: .enterPhrase)), animated: true)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(10)
            make.size.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.leading.equalTo(38)
            make.trailing.equalTo(-38)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(55)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        
        containerIdentityView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(70)
            make.leading.equalTo(44)
            make.trailing.equalTo(-44)
        }
        
        createIdentityView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(22)
            make.trailing.equalTo(-22)
        }
        
        recoverIdentityView.snp.makeConstraints { make in
            make.top.equalTo(createIdentityView.snp.bottom).offset(5)
            make.leading.equalTo(22)
            make.trailing.equalTo(-22)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(containerIdentityView.snp.bottom).offset(70)
            make.centerX.equalToSuperview()
            make.width.equalTo(63)
            make.height.equalTo(2)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        versionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(containerStackView.snp.top).offset(-10)
            make.centerX.equalToSuperview()
            make.width.equalTo(63)
            make.height.equalTo(20)
        }
    }
    
    func timerStart(timeInterval: TimeInterval = 1) {
        timer.start(withTimeInterval: timeInterval) { [weak self] counter in
            guard let self = self else { return }
            UIView.animate(withDuration: 0, delay: 0) {
                print("counter...\(counter)")
                if counter == 0 {
                    DispatchQueue.main.async {
                        self.viewModel.currentIndex = self.viewModel.currentIndex == 1 ? 0 : 1
                        let scrollPosition: UICollectionView.ScrollPosition = self.viewModel.currentIndex == 1 ?  .right : .left
                        self.collectionView.isPagingEnabled = false
                        self.collectionView.scrollToItem(at: IndexPath(item: self.viewModel.currentIndex, section: 0), at: scrollPosition, animated: false)
                        self.collectionView.isPagingEnabled = true
                    }
                    self.timer.stop()
                    self.timerStart()
                }
                
            }
        }
    }
}


extension CryptoSplashViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tutorialArrayImageName.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SplashViewViewCell.className, for: indexPath) as? SplashViewViewCell else { return UICollectionViewCell() }
        cell.setData(with: viewModel.tutorialArrayImageName[indexPath.row])
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.viewModel.currentIndex = indexPath.row 
        switch indexPath.row {
        case 0:
            titleLabel.textColorChange(fullText: "splash_to_open_new_wallet_title".localized, changeText: "splash_wallet".localized)
            pagerFirstView.backgroundColor = .wLightLightBlue
            pagerSecondView.backgroundColor = .wWLightLightGray
        case 1:
            titleLabel.textColorChange(fullText: "splash_to_your_wallet_Second_title".localized, changeText: "splash_wallet".localized)
            pagerFirstView.backgroundColor = .wWLightLightGray
            pagerSecondView.backgroundColor = .wLightLightBlue
        default: break
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 10, height: frameSize.height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

           return 10
       }


    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

           return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
       }
}
