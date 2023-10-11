//
//  SearchWebViewController.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import UIKit
import WebKit

class SearchWebViewController: UIViewController, WKNavigationDelegate {
    
    var selectedNews: NewsArticle!
    
    @IBOutlet private weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setWebView()
    }
    

    func setWebView() {
        guard let url = URL(string: selectedNews.url) else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

}
