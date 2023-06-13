//
//  MnemonicPhrasesView.swift
//  WalletSDK
//
//  Created by ashahrouj on 22/12/2022.
//

import UIKit
import SnapKit

class MnemonicPhrasesView: UIView {

    var didTapPhrasePressed: (MnemonicPhrasesModel) -> Void = {_ in }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .wBlue_EAE
        return view
    }()
    
    private(set) var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MnemonicPhrasesCollectionViewCell.self, forCellWithReuseIdentifier: MnemonicPhrasesCollectionViewCell.className)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    private var viewModel: MnemonicPhrasesViewModel
    init(with viewModel: MnemonicPhrasesViewModel) {
        self.viewModel = viewModel
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
        addSubview(containerView)
        containerView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview()
            make.height.equalTo(230)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func unSelected(phrasesModel: MnemonicPhrasesModel) {
        viewModel.unSelected(with: phrasesModel)
        reloadData()
    }
    
    private func reloadData() {
        collectionView.reloadData()
    }
}


extension MnemonicPhrasesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.phrasesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MnemonicPhrasesCollectionViewCell.className, for: indexPath) as? MnemonicPhrasesCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(with: viewModel.getPhrase(by: indexPath.row), type: viewModel.mnemonicPhrasesType)
        cell.didTapPhrasePressed = { [weak self] phras in
            guard let self = self else { return }
            self.viewModel.selected(with: indexPath.row)
            self.reloadData()
            self.didTapPhrasePressed(self.viewModel.phrasesArray[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: containerView.bounds.width / 3 - 18, height: 54)
    }
}

