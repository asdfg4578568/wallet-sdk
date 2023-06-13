//
//  Spinner.swift
//  WalletSDK
//
//  Created by ashahrouj on 18/01/2023.
//

import Foundation
import UIKit

open class Spinner {
    
    internal static var spinner: UIActivityIndicatorView?
    
    public static var style: UIActivityIndicatorView.Style = .large
    
    public static var baseBackColor = UIColor(white: 0, alpha: 0.6)
    public static var baseColor = UIColor.wSkyBlue
    
    public static func start(style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
        
        if spinner == nil, let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            let frame = UIScreen.main.bounds
            spinner = UIActivityIndicatorView(frame: frame)
            spinner!.backgroundColor = backColor
            spinner!.style = style
            spinner?.color = baseColor
            window.addSubview(spinner!)
            window.isUserInteractionEnabled = true
            spinner?.isUserInteractionEnabled = true
            spinner!.startAnimating()
        }
    }
    
    public static func stop() {
        DispatchQueue.main.async {
            if spinner != nil {
                spinner!.stopAnimating()
                spinner!.removeFromSuperview()
                spinner = nil
                spinner?.isUserInteractionEnabled = true
            }
        }
    }
}
