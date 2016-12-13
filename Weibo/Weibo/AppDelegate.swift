//
//  AppDelegate.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //sleep(3) //让启动页多停留一会
        // 应用程序额外设置
        setupBaseInfo()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.rootViewController = MainViewController()
        window!.makeKeyAndVisible()
        
        // 加载服务器配置
        loadAppInfo()
        
        return true
    }

}

// MARK: - 设置应用程序额外信息
extension AppDelegate {
    fileprivate func setupBaseInfo() {
        // 1. 设置 SVProguressHUD 最小解除时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        // 2. 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        // 3. 设置用户授权显示通知
        // #available 是检测设备版本，如果是 10.0 以上
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .carPlay, .sound]) { (success, error) in
                print("授权 " + (success ? "成功" : "失败"))
            }
        } else {
            // 10.0 以下
            // 取得用户授权显示通知[上方的提示条/声音/BadgeNumber]
            let notifySettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            UIApplication.shared.registerUserNotificationSettings(notifySettings)
        }
    }
}

// MARK: - 从服务器加载应用程序信息
/*
 1.检查沙盒是否有json文件
 2.没有，则加载默认json，并发送网络请求获取json
 3.有，则加载沙盒里的json，发送请求检查是否有更新json
 */
extension AppDelegate {
    fileprivate func loadAppInfo() {
        //1. 模拟异步
        DispatchQueue.global().async {
            // 1> url
            let url = Bundle.main.url(forResource: "main.json", withExtension: nil);
            
            
            // 2> data
            let data = NSData(contentsOf: url!)
            
            // 3> 写入磁盘
            let jsonPath = "main.json".documentDir()
            
            // 直接保存在沙盒，等待下一次程序启动使用！
            data?.write(toFile: jsonPath, atomically: true)
            
            print("应用程序加载完毕 \(jsonPath)")
        }
    }
}


// MARK: - 第三方sdk配置
extension AppDelegate {

}
