//
//  RecentRecordsViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 15/12/2022.
//

import UIKit
import SnapKit
import SwipeCellKit

class RecentRecordsViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(RecentRecordsTableViewCell.self, forCellReuseIdentifier: RecentRecordsTableViewCell.className)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 85
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        tableview.refreshControl = UIRefreshControl()
        return tableview
    }()
    
    let viewModel: RecentRecordsViewModel
    init(with viewModel: RecentRecordsViewModel) {
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
        addCustomBackButtonForXlink()
        title = "recent_records_title".localized
        callPullToRefresh()
//        tryAgainView.didTapTryAgainPressed = {[weak self] in
//            guard let self = self else { return }
//            self.fetcTransactionList()
//        }
        
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
        viewModel.fetchRecentTransactions { [weak self] result in
            guard let self = self else { return }
            switch result {
            case true:
                let shouldHideEmptyScreen: Bool = self.viewModel.recentTransactionArray.count != 0
                self.tableView.reloadData()
                //self.tryAgainView.isHidden = true
                self.tableView.isHidden = !shouldHideEmptyScreen
                //self.emptyView.isHidden = shouldHideEmptyScreen
                
            case false:
                self.tableView.isHidden = true
                //self.emptyView.isHidden = true
                //self.tryAgainView.isHidden = false
            }
        }
    }
    
    func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .wWhite
        tableView.refreshControl?.addTarget(self, action: #selector(callPullToRefresh), for: .valueChanged)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func callPullToRefresh() {
        fetcTransactionList()
    }
}

//SwipeTableViewCellDelegate
extension RecentRecordsViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentTransactionArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentRecordsTableViewCell.className) as! RecentRecordsTableViewCell
        cell.selectionStyle = .none
        cell.setData(with: viewModel.recentTransactionArray[indexPath.row])
        //cell.delegate = self /// for SwipeAction
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.recentTransactionArray.count - 5, !viewModel.isLoading {
            viewModel.loadMoreData()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recentTransaction = viewModel.recentTransactionArray[indexPath.row]
        self.navigationController?.pushViewController(RecentRecordsDetailsViewController(with: RecentRecordsDetailsViewModel(with: CurrencyModel(coinType: recentTransaction.asset.coinId, name: recentTransaction.asset.name, description: recentTransaction.asset.name), and: recentTransaction.txid, status: recentTransaction.state == .success ? .success : .fail)), animated: true)
    }
    
    /*
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "other_delete_title".localized) { action, indexPath in
            // handle action by updating model with deletion
        }

        deleteAction.font = .font(name: .semiBold, and: 10)
        // customize the action appearance
        deleteAction.image = UIImage(named: "swipe_delete_icon")

        return [deleteAction]
    }
    */
}
