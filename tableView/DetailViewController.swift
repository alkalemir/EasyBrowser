//
//  DetailViewController.swift
//  tableView
//
//  Created by Emir Alkal on 8.06.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var urlString: String?
    var allowedSites: [String]?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        navigationController?.isToolbarHidden = false
        
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPage(name: urlString!)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
        let forwardButton = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(goForward))
        toolbarItems = [refreshButton, backButton, forwardButton]
    }
    
    @objc func goBack() {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func goForward() {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    func loadPage(name: String) {
        let url = URL(string: "https://\(name)")!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for webSite in allowedSites! {
                if host.contains(webSite) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        
        let ac = UIAlertController(title: "Error", message: "This site is blocked!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
        decisionHandler(.cancel)
    }
    
}
