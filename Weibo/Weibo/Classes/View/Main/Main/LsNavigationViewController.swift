//
//  LsNavigationViewController.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/9.
//  Copyright © 2016年 Ls. All rights reserved.
//
/**
 1. 隐藏默认导航条
 2. 统一处理push
 */
import UIKit

class LsNavigationViewController: UINavigationController {
    override class func initialize() {
        let  bar = UINavigationBar.appearance()
        // 隐藏阴影线
        bar.shadowImage = UIImage()
        bar.isTranslucent = true
        
        // 设置导航条标题字体大小和颜色
        bar.titleTextAttributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 17),NSForegroundColorAttributeName: UIColor.white]
        bar.tintColor = SLColor(0, g: 0, b: 0, a: 0.7)
        bar.barTintColor = UIColor.white
        
        // 设置item
        let item = UIBarButtonItem.appearance()
        var itemAttrs: [String: AnyObject] = Dictionary()
        itemAttrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 15)
        itemAttrs[NSForegroundColorAttributeName] = UIColor.orange
        item.setTitleTextAttributes((itemAttrs as [String: AnyObject]), for: UIControlState.normal)
        
        var itemDisabledAttrs: [String: AnyObject] = Dictionary()
        itemDisabledAttrs[NSFontAttributeName] = itemAttrs[NSFontAttributeName]
        itemDisabledAttrs[NSForegroundColorAttributeName] = UIColor.lightGray
        item.setTitleTextAttributes(itemDisabledAttrs as [String: AnyObject], for: UIControlState.disabled)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏默认导航条
        navigationBar.isHidden = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            // 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
            
            // 判断控制器的类型
            if let vc = viewController as? BaseViewController {
                
                var title = "返回"
                
                // 判断控制器的级数，只有一个子控制器的时候，显示栈底控制器的标题
                if childViewControllers.count == 1 {
                    // title 显示首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                
                // 取出自定义的 navItem，设置左侧按钮作为返回按钮
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(back), isBack: true)
            }
        }
        
        super.pushViewController(viewController, animated: true)

    }
    
    /// POP 返回到上一级控制器
  func back() {
        popViewController(animated: true)
    }

  
}
