//
//  ThirdViewController.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 04 on 4/19/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import WebKit
import NVActivityIndicatorView

class ThirdViewController: UIViewController, NVActivityIndicatorViewable, WKUIDelegate, WKNavigationDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loaderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        showLoader()
        setupWebView()
        
        let myURL = URL(string:"https://www.google.com")
        let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
    }
    
    func setupWebView(){
         webView.uiDelegate = self
         webView.navigationDelegate = self
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         hideLoader()
    }
    
    func showLoader(){
        loaderView.isHidden = false
        
        let loaderSize = CGSize(width: 70.0, height: 70.0)
        startAnimating(loaderSize, message: " Loading...", type: .ballScale, color: .white, textColor: .white, fadeInAnimation: nil)
    }
    
     func hideLoader(){
        loaderView.isHidden = true
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        let url = URL(string: "http://\(searchBar.text!)")
        let request = URLRequest(url: url!)
        webView.load(request)
        showLoader()
    }
}
