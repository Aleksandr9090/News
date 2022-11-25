//
//  NewsWebViewController.swift
//  News
//
//  Created by Aleksandr on 24.11.2022.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController {
    
    var newsUrl: String!
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let webUrl = newsUrl else { return }
        guard
            let webUrlString = webUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            return
        }
        guard let url = URL(string: webUrlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        
    }
    
}

// MARK: - WKUIDelegate
extension NewsWebViewController: WKUIDelegate {
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
}
