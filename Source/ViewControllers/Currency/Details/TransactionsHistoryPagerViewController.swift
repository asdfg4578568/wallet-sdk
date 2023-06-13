//
//  TransactionsHistoryPagerViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 20/12/2022.
//

import UIKit
import XLPagerTabStrip
import SnapKit

class TransactionsHistoryPagerViewController: UIViewController {
    
    var didTapOnTransaction: (TransactionHistoryModel) -> Void = {_ in }

    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(TransactionsHistoryViewCell.self, forCellReuseIdentifier: TransactionsHistoryViewCell.className)
        tableview.rowHeight = 65
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.showsVerticalScrollIndicator = false
        tableview.refreshControl = UIRefreshControl()
        if #available(iOS 15.0, *) {
            tableview.sectionHeaderTopPadding = 0
        }
        return tableview
    }()

    private let emptyView: EmptyView = {
        let view = EmptyView(with: "no_data_found".localized, iconName: "empty_transaction_icon")
        return view
    }()
    
    private let tryAgainView: TryAgainView = {
        let view = TryAgainView()
        view.isHidden = true
        return view
    }()
    
    private var itemInfo: IndicatorInfo
    private let viewModel: TransactionsHistoryViewModel
    private var dispatchGroup: DispatchGroup?
    
    init(with itemInfo : IndicatorInfo, and viewModel: TransactionsHistoryViewModel) {
        self.itemInfo = itemInfo
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tryAgainView.didTapTryAgainPressed = {[weak self] in
            guard let self = self else { return }
            self.fetcTransactionList()
        }
        
        viewModel.didFinishedloadMore = {[weak self] isSuccess in
            guard let self = self else { return }
            if isSuccess {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
        
    private func fetcTransactionList() {
        viewModel.refreshData()
        dispatchGroup?.enter()
        viewModel.fetcTransactionList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case true:
                let shouldHideEmptyScreen: Bool = self.viewModel.transactions.count != 0
                self.tableView.reloadData()
                self.tryAgainView.isHidden = true
                self.tableView.isHidden = !shouldHideEmptyScreen
                self.emptyView.isHidden = shouldHideEmptyScreen
                
            case false:
                self.tableView.isHidden = true
                self.emptyView.isHidden = true
                self.tryAgainView.isHidden = false
            }
            self.dispatchGroup?.leave()
        }
    }
    
    func setupViews() {
        view.addSubviews(with: [tableView, emptyView, tryAgainView])
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tryAgainView.snp.makeConstraints { make in
            make.centerY.centerX.equalTo(tableView)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(75)
        }
    }
    
    @objc func callPullToRefresh() {
        fetcTransactionList()
    }
    
    func setDispatchGroup(with dispatchGroup: DispatchGroup) {
        self.dispatchGroup = dispatchGroup
    }
}


extension TransactionsHistoryPagerViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionsHistoryViewCell.className) as! TransactionsHistoryViewCell
        cell.setData(with: viewModel.getTransactionsItem(by: indexPath.row))
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapOnTransaction(viewModel.transactions[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.transactions.count - 5, !viewModel.isLoading {
            viewModel.loadMoreData()
        }
    }
}

extension TransactionsHistoryPagerViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
