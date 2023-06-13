//
//  SetGasFeeViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 27/12/2022.
//

import UIKit
import SnapKit

class SetGasFeeViewController: UIViewController {

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
    /*
    private let minersFeesView: MinersFeesView = {
        let view = MinersFeesView(with: .setGasFee)
        view.backgroundColor = .clear
        return view
    }()
    */
    private let setGasFeesPriorityView: SetGasFeesPriorityView
    
    var didFeesPriorityPressed: (Int) -> Void = { _ in }
    private var viewModel: SetGasFeeViewModel
    init(with viewModel: SetGasFeeViewModel) {
        self.viewModel = viewModel
        self.setGasFeesPriorityView = SetGasFeesPriorityView(with: viewModel.transferViewModel.gasFeesArry)
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .wWhite
        super.viewDidLoad()
        title = "transfer_set_gas_fee".localized
        addCustomBackButtonForXlink()
        /*
        minersFeesView.setData(currencyModel: viewModel.transferViewModel.currencyModel)
        minersFeesView.didNotePressed = {[weak self] data in
            guard let self = self else { return }
            let view =  PopUpActionWithIconViewController(text: "The miner's fee is an estimated value and may be slightly different from the actual one. Excessive low miner's fee may lead to a long time on confirmation. Please set a reasonable miner's fee", titleButton: "Got It", iconName: "fees_popup_icon")
            
            view.didTapPressed = {
                
            }
            self.present(view, animated: true)
            
        }
         */
        
        setGasFeesPriorityView.didFeesPriorityPressed = { [weak self] index in
            guard let self = self else { return }
            self.didFeesPriorityPressed(index)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        //containerView.addSubviews(with: [minersFeesView, setGasFeesPriorityView])
        containerView.addSubviews(with: [setGasFeesPriorityView])
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        /*
        minersFeesView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
         */
        
        setGasFeesPriorityView.snp.makeConstraints { make in
            //make.top.equalTo(minersFeesView.snp.bottom).offset(20)
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
