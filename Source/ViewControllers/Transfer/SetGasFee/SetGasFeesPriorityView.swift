//
//  SetGasFeesPriorityView.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import UIKit
import SnapKit

class SetGasFeesPriorityView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "transfer_set_priority".localized
        label.font = UIFont.font(name: .semiBold, and: 16)
        label.textColor = .wWLightBlack
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(GasFeesPriorityViewCell.self, forCellReuseIdentifier: GasFeesPriorityViewCell.className)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 65
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    var didFeesPriorityPressed: (Int) -> Void = { _ in }
    let gasFeesPriorityArray: [GasFeesPriorityModel]
    init(with gasFeesPriorityArray: [GasFeesPriorityModel]) {
        self.gasFeesPriorityArray = gasFeesPriorityArray
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [titleLabel, tableView])
    }
    
    func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(195)
        }
    }
    
    func setData() {
        tableView.reloadData()
    }
    
}


extension SetGasFeesPriorityView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gasFeesPriorityArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GasFeesPriorityViewCell.className) as! GasFeesPriorityViewCell
        cell.selectionStyle = .none
        cell.setData(with: gasFeesPriorityArray[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didFeesPriorityPressed(indexPath.row)
    }
}
