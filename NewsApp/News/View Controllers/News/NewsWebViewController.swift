//
//  NewsWebViewController.swift
//  News
//
//  Created by Vitya Mandryk on 11.10.2023.
//

import UIKit
import WebKit


class NewsWebViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet private weak var webView: WKWebView!
    
    var newsSelected: NewsArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
        setWebView()
    }
    

    func setWebView() {
        guard let url = URL(string: newsSelected.url) else {
            return
        }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
