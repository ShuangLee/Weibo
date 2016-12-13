//
//  UIScreen+Extension.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/12.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

extension UIScreen {
    class func sl_screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    class func sl_screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    class func sl_scale() -> CGFloat {
        return UIScreen.main.scale
    }
}
