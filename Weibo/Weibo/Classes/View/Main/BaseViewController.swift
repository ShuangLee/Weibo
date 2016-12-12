//
//  BaseViewController.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/9.
//  Copyright © 2016年 Ls. All rights reserved.
//
/*
    基类功能
    1. 设置界面共同的地方 (自定义导航条+navItem)
    2. 重写title属性
    3. 设置表格视图
    4. 封装刷新逻辑 上拉／下拉
    5. 访客视图    用户未登录的界面显示
 */

import UIKit

class BaseViewController: UIViewController {
    /// 访客视图信息字典
    var visitorInfoDictionary: [String: String]?
    /// 自定义的导航条目 - 以后设置导航栏内容，统一使用 navItem
    lazy var navItem = UINavigationItem()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
