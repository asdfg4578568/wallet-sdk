//
//  SuggestionPhrasesView.swift
//  WalletSDK
//
//  Created by ashahrouj on 23/12/2022.
//

import UIKit
import SnapKit

class SuggestionPhrasesView: UIView {

    var didTapOnPhrase: (MnemonicPhrasesModel) -> Void = {_ in }

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wGray8
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .wGray8
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let firstButton: UIButton = {
        let nextButton = UIButton()
        nextButton.tag = 0
        nextButton.isHidden = true
        nextButton.setTitleColor(.wWLightBlack, for: .normal)
        nextButton.setTitle("other_next_title".localized, for: .normal)
        nextButton.titleLabel?.font = .font(name: .semiBold, and: 14)
        return nextButton
    }()
    
    private let secondButton: UIButton = {
        let nextButton = UIButton()
        nextButton.tag = 1
        nextButton.isHidden = true
        nextButton.setTitleColor(.wWLightBlack, for: .normal)
        nextButton.setTitle("other_next_title".localized, for: .normal)
        nextButton.titleLabel?.font = .font(name: .semiBold, and: 14)
        return nextButton
    }()
    
    private let thirdButton: UIButton = {
        let nextButton = UIButton()
        nextButton.tag = 2
        nextButton.isHidden = true
        nextButton.setTitleColor(.wWLightBlack, for: .normal)
        nextButton.setTitle("other_next_title".localized, for: .normal)
        nextButton.titleLabel?.font = .font(name: .semiBold, and: 14)
        return nextButton
    }()
    
    private let fourthButton: UIButton = {
        let nextButton = UIButton()
        nextButton.tag = 3
        nextButton.isHidden = true
        nextButton.setTitleColor(.wWLightBlack, for: .normal)
        nextButton.setTitle("other_next_title".localized, for: .normal)
        nextButton.titleLabel?.font = .font(name: .semiBold, and: 14)
        return nextButton
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        containerView.corner(cornerRadius: 8)
    }
    
    func setupViews() {
        backgroundColor = .clear
        addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubviews(with: [firstButton, secondButton, thirdButton, fourthButton])
        
        firstButton.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
        fourthButton.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)

    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private(set) var phrasesArray: [MnemonicPhrasesModel] = []
    func filtered(with phrases: [MnemonicPhrasesModel]) {
        clearData()
        phrasesArray = phrases
        for (index,item) in phrases.enumerated() {
            switch index {
            case 0:
                firstButton.isHidden = false
                firstButton.setTitle("\(item.phrase)", for: .normal)
            case 1:
                secondButton.isHidden = false
                secondButton.setTitle("\(item.phrase)", for: .normal)
            case 2:
                thirdButton.isHidden = false
                thirdButton.setTitle("\(item.phrase)", for: .normal)
            case 3:
                fourthButton.isHidden = false
                fourthButton.setTitle("\(item.phrase)", for: .normal)
            default: continue
            }
        }
    }
    
    func clearData() {
        phrasesArray = []
        firstButton.isHidden = true
        firstButton.setTitle("", for: .normal)
        
        secondButton.isHidden = true
        secondButton.setTitle("", for: .normal)
        
        thirdButton.isHidden = true
        thirdButton.setTitle("", for: .normal)
        
        fourthButton.isHidden = true
        fourthButton.setTitle("", for: .normal)
    }
    
    @objc func pressed(_ button: UIButton) {
        didTapOnPhrase(phrasesArray[button.tag])
    }
}
