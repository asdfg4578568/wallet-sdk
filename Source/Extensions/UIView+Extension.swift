//
//  UIView+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 06/12/2022.
//

import UIKit

extension UIView {
    
    func addSubviews(with views: [UIView]) {
        for view in views { addSubview(view) }
    }
    
    func addBorders(withEdges edges: [UIRectEdge]) {
        layer.cornerRadius = 30
        clipsToBounds = true
        edges.forEach({ edge in
            switch edge {
            case .left: layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            case .right: layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
            case .top: layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            case .bottom: layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            default: break
            }
        })
    }
    
    func addGradientLayer(with colors: [CGColor]) {
        let gradient = CAGradientLayer()
        gradient.colors = colors
        gradient.locations = [0, 1]
        gradient.frame = bounds
        gradient.cornerRadius = 10
        layer.insertSublayer(gradient, at: 0)
    }
    
    func corner(cornerRadius: CGFloat = 10,
                borderWidth: CGFloat = 0,
                borderColor: UIColor = .clear) {
        // To provide the corner radius
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }
    
    func dropShadow(with shadowColor: CGColor, onlyBottom: Bool = false, shadowOpacity: Float = 1) {
        // To provide the shadow below only
        
        if onlyBottom {
            let height = frame.height
            let width = frame.width
            let shadowSize: CGFloat = 3
            let contactRect = CGRect(x: -shadowSize, y: height, width: width, height: shadowSize)
            layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        }
        
        // To provide the shadow
        layer.shadowRadius = 5
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = shadowColor
        layer.masksToBounds = false
    }
    
}
