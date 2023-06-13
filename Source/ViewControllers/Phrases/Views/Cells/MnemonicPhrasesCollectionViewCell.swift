//
//  MnemonicPhrasesCollectionViewCell.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import UIKit
import SnapKit

class MnemonicPhrasesCollectionViewCell: UICollectionViewCell {
    
    var didTapPhrasePressed: (MnemonicPhrasesModel) -> Void = {_ in }
    var didTapRemovePressed: (MnemonicPhrasesModel) -> Void = {_ in }

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let phraseButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.wWLightBlack, for: .normal)
        button.titleLabel?.font = .font(name: .semiBold, and: 14)
        button.backgroundColor = .wWhite
        return button
    }()
    
    private let removeButton: UIButton = {
        let button = UIButton()
        button.setImage("remove_phrase_icon".imageByName, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        phraseButton.corner(cornerRadius: 4)
        //removeButton.corner(cornerRadius: removeButton.bounds.width / 2)
    }
    
    func setupViews() {
        addSubview(containerView)
        containerView.addSubviews(with: [phraseButton, removeButton])
        phraseButton.addTarget(self, action: #selector(phrasePressed), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(removePressed), for: .touchUpInside)
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(54)
        }
        
        phraseButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.height.width.equalTo(12)
        }
    }
    
    private var model: MnemonicPhrasesModel?
    private var type: MnemonicPhrasesType = .clickable
    func setData(with model: MnemonicPhrasesModel, type: MnemonicPhrasesType = .clickable) {
        self.model = model
        self.type = type
        
        switch type {
        case .clickable:
            removeButton.isHidden = true
            phraseButton.isEnabled = !model.isSelected
            phraseButton.alpha = model.isSelected ? 0.5 : 1
            
        case .removable:
            removeButton.isHidden = false
            phraseButton.isEnabled = true
            
        case .displayOnly:
            removeButton.isHidden = true
            phraseButton.isEnabled = false
            phraseButton.alpha = 1
        }
        
        phraseButton.setTitle(model.phrase.lowercased(), for: .normal)
    }
    
    @objc private func removePressed() {
        guard let model = model else { return }
        didTapRemovePressed(model)
    }
    
    @objc private func phrasePressed() {
        guard let model = model else { return }
        
        switch self.type {
        case .clickable: didTapPhrasePressed(model)
        case .removable: didTapRemovePressed(model)
        case .displayOnly: break
        }
    }
    
}
