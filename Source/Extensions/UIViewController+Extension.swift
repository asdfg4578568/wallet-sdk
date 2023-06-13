//
//  UIViewController+Extension.swift
//  WalletSDK
//
//  Created by ashahrouj on 14/12/2022.
//

import UIKit
import ToastViewSwift

extension UIViewController {
    
    func showToast(with text: String) {
        let config = ToastConfiguration(
            direction: .bottom,
            autoHide: true,
            enablePanToClose: true,
            displayTime: 0.8,
            animationTime: 0.2
        )
        
        let attributes = [
            NSAttributedString.Key.font: UIFont.font(name: .semiBold, and: 15),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        let attributedString  = NSMutableAttributedString(string: text , attributes: attributes)
        
        let toast = Toast.text(attributedString, config: config)
        toast.show()
    }
    
    func displayTryAgain(completionHandler: @escaping () -> Void) {
        let view =  PopUpTwoActionsViewController(text: "something_wrong_try_again".localized, titleLeftButton: "cancel_title".localized, titleRightButton: "other_try_again_title".localized)
        
        view.rightPressed = { 
            view.dismiss(animated: true)
            completionHandler()
        }
        
        view.leftPressed = {[weak self] in
            view.dismiss(animated: true)
            self?.navigationController?.popViewController(animated: true)
        }
        
        self.present(view, animated: true)
    }
}


extension UIViewController {
    
    func addCustomBackButtonForXlink() {
        let backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        backBtn.setImage("back_for_xlink".imageByName, for: .normal)
        backBtn.addTarget(self, action: #selector(backActionForXlink(_:)), for: .touchUpInside)
        backBtn.addDefaultShadowForXlink()
        self.hidesBottomBarWhenPushed = true
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        let leftBtn = UIBarButtonItem(customView: backBtn)
        self.navigationItem.leftBarButtonItem = leftBtn
    }
    
    @objc
    func backActionForXlink(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

public extension UIView {
    
    @discardableResult
    func addDefaultShadowForXlink() -> UIView {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.06)
        layer.shadowOffset = CGSize(width: 0, height: 10.0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 10
        return self
    }
}


