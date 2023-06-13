//
//  WebViewController.swift
//  WalletSDK
//
//  Created by ashahrouj on 02/01/2023.
//

import UIKit
import SnapKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    let url: String
    init(with url: String ) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomBackButtonForXlink()
    }
    

    func setupViews() {
        view.addSubviews(with: [webView])
        webView.navigationDelegate = self
        
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
