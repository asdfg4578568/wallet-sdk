//
//  AddressListViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import UIKit
import SnapKit
import SwipeCellKit

class AddressListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(AddressViewCell.self, forCellReuseIdentifier: AddressViewCell.className)
        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 95
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("other_add_title".localized, for: .normal)
        button.backgroundColor = .wSkyBlue
        button.titleLabel?.font = .font(name: .semiBold, and: 16)
        return button
    }()
    
    private let emptyView: EmptyView = {
        let view = EmptyView(with: "no_data_found".localized, iconName: "empty_transaction_icon")
        return view
    }()
    
    var didAddressSelected: (String) -> Void = { _ in }
    
    let viewModel: AddressListViewModel
    init(with viewModel: AddressListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButtonForXlink()
        title = viewModel.title
        addButton.corner(cornerRadius: 28)
        addButton.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getAddresses {[weak self] isSuccess in
            switch isSuccess {
            case true: self?.reloadData()
            case false: print("something wrong when getAddresses")
            }
        }
    }
    
    func setupViews() {
        view.addSubviews(with: [tableView, emptyView, addButton])
        view.backgroundColor = .wWhite
        tableView.reloadData()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.leading.trailing.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.height.equalTo(tableView.snp.height)
            make.width.equalTo(tableView.snp.width)
            make.centerY.centerY.equalTo(tableView)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(55)
        }
    }
    
    func setData() {
        
    }
    
    private func reloadData() {
        let shouldHideEmptyScreen: Bool = viewModel.addresses.count != 0
        tableView.reloadData()
        tableView.isHidden = !shouldHideEmptyScreen
        emptyView.isHidden = shouldHideEmptyScreen
    }
    
    @objc private func addPressed() {
        self.navigationController?.pushViewController(AddAddressViewController(with: AddAddressViewModel(with: viewModel.currencyModel)), animated: true)
    }
}

extension AddressListViewController: UITableViewDataSource, UITableViewDelegate, SwipeTableViewCellDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.addresses.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressViewCell.className) as! AddressViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.setData(with: viewModel.addresses[indexPath.row])
        
        cell.didCopyPressed = {[weak self] model in
            guard let self = self else { return }
            self.showToast(with: "toast_copied".localized)
            UIPasteboard.general.string = model.address
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didAddressSelected(viewModel.addresses[indexPath.row].address)
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "other_delete_title".localized) {[weak self] action, indexPath in
            guard let self = self else { return }
            
            
            let view =  PopUpTwoActionsViewController(text: "address_are_you_sure_delete_address".localized, titleLeftButton: "cancel_title".localized, titleRightButton: "yes_title".localized)
            
            view.rightPressed = {[weak self] in
                guard let self = self else { return }
                view.dismiss(animated: true)
                self.viewModel.deleteAddressBook(with: self.viewModel.addresses[indexPath.row].address) {[weak self] isSuccess in
                    switch isSuccess {
                    case true: self?.reloadData()
                    case false: print("something wrong when deleteAddressBook")
                    }
                }
            }
            
            view.leftPressed = {
                view.dismiss(animated: true)
            }
            
            self.present(view, animated: true)
            
            
        }

        deleteAction.font = .font(name: .semiBold, and: 10)
        // customize the action appearance
        deleteAction.image = "swipe_delete_icon".imageByName

        return [deleteAction]
    }
    
}
