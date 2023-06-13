//
//  TransactionsHistoryPagerTab.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/01/2023.
//

import Foundation
import XLPagerTabStrip
import SnapKit

class TransactionsHistoryPagerTab: ButtonBarPagerTabStripViewController {
    
    private(set) var allVC : TransactionsHistoryPagerViewController
    private(set) var sendVC : TransactionsHistoryPagerViewController
    private(set) var receiveVC : TransactionsHistoryPagerViewController
    
    var didTapOnTransaction: (TransactionHistoryModel) -> Void = {_ in }

    init(with coinType: Int) {
        allVC = TransactionsHistoryPagerViewController(with: IndicatorInfo(title: TransactionsHistoryOptions.all.title), and: TransactionsHistoryViewModel(with: .all, coinType: coinType))
        sendVC = TransactionsHistoryPagerViewController(with: IndicatorInfo(title: TransactionsHistoryOptions.send.title), and: TransactionsHistoryViewModel(with: .send, coinType: coinType))
        receiveVC = TransactionsHistoryPagerViewController(with: IndicatorInfo(title: TransactionsHistoryOptions.receive.title), and: TransactionsHistoryViewModel(with: .receive, coinType: coinType))
        
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allVC.didTapOnTransaction = { [weak self] model in
            self?.didTapOnTransaction(model)
        }
        
        self.sendVC.didTapOnTransaction = { [weak self] model in
            self?.didTapOnTransaction(model)
        }
        
        self.receiveVC.didTapOnTransaction = { [weak self] model in
            self?.didTapOnTransaction(model)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupViews() {
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarItemTitleColor = .wBlack
        settings.style.selectedBarBackgroundColor = .wSkyDarkBlue
        settings.style.buttonBarItemFont = .font(name: .regular, and: 14)
        settings.style.selectedBarHeight = 1.3
        settings.style.buttonBarMinimumLineSpacing = 10
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
    }
    
    func setupConstraints() {
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [allVC, sendVC, receiveVC]
    }
    
    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
