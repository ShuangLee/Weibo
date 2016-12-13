//
//  UILabel+Extension.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/12.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

extension UILabel {
    
    /// 创建label
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - fontSize: 字体大小
    ///   - color: 颜色
    /// - Returns: UILabel
    class func sl_label(text: String, fontSize: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = color
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }
}
