//
//  UIBarButtonItem+Extension.swift
//  Extension-Swift3.0
//
//  Created by 浮生若梦 on 2016/12/12.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem
    ///
    /// - parameter title:    title
    /// - parameter fontSize: fontSize，默认 16 号
    /// - parameter target:   target
    /// - parameter action:   action
    /// - parameter isBack:   是否是返回按钮，如果是加上箭头
    ///
    /// - returns: UIBarButtonItem
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action: Selector, isBack: Bool = false) {
        let btn: UIButton = UIButton.sl_titleButton(title: title, fontSize: fontSize, color: UIColor.darkGray, highlightColor: UIColor.orange, backgroundImageName: nil)
        
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: UIControlState(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            
            btn.sizeToFit()
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        // self.init 实例化 UIBarButtonItem
        self.init(customView: btn)
    }
}
