//
//  WBWebViewController.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

/// 网页控制器
class WBWebViewController: BaseViewController {

    fileprivate lazy var webView = UIWebView(frame: UIScreen.main.bounds)
    
    /// 要加载的 URL 字符串
    var urlString: String? {
        didSet {
            
            guard let urlString = urlString,
                let url = URL(string: urlString)
                else {
                    return
            }
            
            webView.loadRequest(URLRequest(url: url))
        }
    }
}

extension WBWebViewController {
    
    override func setupTableView() {
        
        // 设置标题
        navItem.title = "网页"
        
        // 设置 webView
        view.insertSubview(webView, belowSubview: navigationBar)
        
        webView.backgroundColor = UIColor.white
        
        // 设置 contentInset
        webView.scrollView.contentInset.top = navigationBar.bounds.height
    }
}
