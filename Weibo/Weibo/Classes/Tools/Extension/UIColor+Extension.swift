//
//  UIColor+Extension.swift
//  Extension-Swift3.0
//
//  Created by 浮生若梦 on 2016/12/7.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

extension UIColor {
    //返回随机颜色
    open class var randomColor:UIColor {
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
    
    class func rgbaColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
