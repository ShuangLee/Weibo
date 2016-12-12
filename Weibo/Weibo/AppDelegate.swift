//
//  AppDelegate.swift
//  Weibo
//
//  Created by 浮生若梦 on 2016/12/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //sleep(3) //让启动页多停留一会
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.rootViewController = MainViewController()
        window!.makeKeyAndVisible()
        return true
    }

}

