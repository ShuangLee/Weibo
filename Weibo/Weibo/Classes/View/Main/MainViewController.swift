//
//  MainViewController.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    // MARK: - 私有控件
    /// 撰写按钮
    fileprivate lazy var composeButton: UIButton = UIButton.sl_imageButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = SLColor(111, g: 111, b: 111, a: 1.0)
        
        // 隐藏阴影线
        tabBar.shadowImage = UIImage()
        
        // 设置文字属性
        var attrs: [String: AnyObject] = Dictionary()
        attrs[NSFontAttributeName] = UIFont.systemFont(ofSize: 12);
        attrs[NSForegroundColorAttributeName] = UIColor.gray
        var selectedAttrs : [String: AnyObject] = Dictionary()
        selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName]
        selectedAttrs[NSForegroundColorAttributeName] = UIColor.orange
        
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes(attrs as [String: AnyObject], for: UIControlState.normal)
        item.setTitleTextAttributes(selectedAttrs as [String: AnyObject], for: UIControlState.selected)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildControllers()
        setupComposeButton()
    }
    
    /// 撰写微博
    // @objc 允许通过oc运行时消息机制访问方法
    @objc fileprivate func composeStatus() {
        print("撰写微博")
        // 是否登录
    }
    
    /**
     portrait    : 竖屏，肖像
     landscape   : 横屏，风景画
     - 使用代码控制设备的方向，好处，可以在在需要横屏的时候，单独处理！
     - 设置支持的方向之后，当前的控制器及子控制器都会遵守这个方向！
     - 如果播放视频，通常是通过 modal 展现的！
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

// MARK: - 设置界面
extension MainViewController {
    /// 设置撰写按钮
    fileprivate func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // 计算按钮的宽度
        let count = CGFloat(childViewControllers.count)
        // 将向内缩进的宽度
        let w = tabBar.bounds.width / count
        
        // CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        print("撰写按钮宽度 \(composeButton.bounds.width)")
        
        // 按钮监听方法
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
    }
    
    /// 设置所有子控制器
    fileprivate func setupChildControllers() {
        // 0. 获取沙盒 json 路径
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDir as NSString).appendingPathComponent("main.json")
        
        // 加载 data
        var data = NSData(contentsOfFile: jsonPath)
        
        // 判断 data 是否有内容，如果没有，说明本地沙盒没有文件
        if data == nil {
            // 从 Bundle 加载 data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            
            data = NSData(contentsOfFile: path!)
        }
        
        // data 一定会有一个内容，反序列化
        // 反序列化转换成数组
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: AnyObject]]
            else {
                return
        }
        
        // 遍历数组，循环创建控制器数组
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        
        // 设置 tabBar 的子控制器
        viewControllers = arrayM
    }

    /// 使用字典创建一个子控制器
    ///
    /// - parameter dict: 信息字典[clsName, title, imageName, visitorInfo]
    ///
    /// - returns: 子控制器
    fileprivate func controller(dict: [String: AnyObject]) -> UIViewController {
        
        // 1. 取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? BaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String]
            else {
                
                return UIViewController()
        }
        
        // 2. 创建视图控制器
        let vc = cls.init()
        
        vc.title = title
        
        // 设置控制器的访客信息字典
        vc.visitorInfoDictionary = visitorDict
        
        // 3. 设置图像
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        // 实例化导航控制器的时候，会调用 push 方法将 rootVC 压栈
        let nav = LsNavigationViewController(rootViewController: vc)
        
        return nav
    }
}
