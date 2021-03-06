//
//  UIImageView+Extension.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/13.
//  Copyright © 2016年 Ls. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    /// 隔离 SDWebImage 设置图像函数
    ///
    /// - parameter urlString:        urlString
    /// - parameter placeholderImage: 占位图像
    /// - parameter isAvatar:         是否头像
    func sl_setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false) {
        
        // 处理 URL
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                // 设置占位图像
                image = placeholderImage
                
                return
        }
        
        // 可选项只是用在 Swift，OC 有的时候用 ! 同样可以传入 nil
        sd_setImage(with: url, placeholderImage: placeholderImage, options: [], progress: nil) { [weak self] (image, _, _, _) in
            
            // 完成回调 - 判断是否是头像
            if isAvatar {
                self?.image = image?.sl_avatarImage(size: self?.bounds.size)
            }
        }
    }
}
