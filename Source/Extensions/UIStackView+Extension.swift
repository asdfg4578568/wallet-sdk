//
//  UIStackView+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 17/12/2022.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(with views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
