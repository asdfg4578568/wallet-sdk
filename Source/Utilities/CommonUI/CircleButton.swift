//
//  CircleButton.swift
//  WalletSDK
//
//  Created by ashahrouj on 07/12/2022.
//

import UIKit

class CircleButton: UIButton {
    
    var pressed: () -> Void = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.corner(cornerRadius: layer.bounds.width / 2)
        // To handle the light color in circle (borderWidth: xNumber, borderColor: .xColor)
    }
    
    func setupViews() {
        backgroundColor = .clear
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func setData(with backgroundColor: UIColor, and imageName: String) {
        self.backgroundColor = backgroundColor
        setImage(imageName.imageByName, for: .normal)
    }
    
    @objc private func buttonPressed() {
        pressed()
    }
}
