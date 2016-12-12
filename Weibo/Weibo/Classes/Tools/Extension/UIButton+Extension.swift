//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/12.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 创建文本按钮
    ///
    /// - Parameters:
    ///   - title: 按钮文字
    ///   - fontSize: 字体大小
    ///   - color: 默认颜色
    ///   - highlightColor: 高亮颜色
    ///   - backgroundImageName: 背景图片
    /// - Returns: UIButton
    class func sl_titleButton(title: String, fontSize: CGFloat, color: UIColor, highlightColor: UIColor?, backgroundImageName: String?) -> UIButton {
        let btn = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(color, for: .normal)
        if let highlightColor = highlightColor {
            btn.setTitleColor(highlightColor, for: .highlighted)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        if let imageName = backgroundImageName {
            btn.setBackgroundImage(UIImage(named: imageName), for: .normal)
            let imageNameHL = imageName.appending("_highlighted")
            btn.setBackgroundImage(UIImage(named: imageNameHL), for: .highlighted)
        }
        
        btn.sizeToFit()
        
        return btn
    }
    
    
    /// 图片按钮
    ///
    /// - Parameters:
    ///   - imageName: 图片
    ///   - backgroundImageName: 背景图片
    /// - Returns: UIButton
    class func sl_imageButton(imageName: String, backgroundImageName: String?) -> UIButton {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        
        if let backgroundImageName = backgroundImageName {
            btn.setBackgroundImage(UIImage(named: backgroundImageName), for: .normal)
            btn.setBackgroundImage(UIImage(named: backgroundImageName + "highlighted"), for: .highlighted)
        }
       
        btn.sizeToFit()
        
        return btn
    }
}
