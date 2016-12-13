//
//  WBStatusPicture.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/13.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

/// 微博配图模型
class WBStatusPicture: NSObject {
    
    /// 缩略图地址 - 新浪返回的缩略图令人发指
    var thumbnail_pic: String? {
        didSet {
            // print(thumbnail_pic)
            // 设置大尺寸图片
            largePic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/large/")
            
            // 更改缩略图地址
            thumbnail_pic = thumbnail_pic?.replacingOccurrences(of: "/thumbnail/", with: "/wap360/")
        }
    }
    
    /// 大尺寸图片
    var largePic: String?
    
    override var description: String {
        return yy_modelDescription()
    }
}

