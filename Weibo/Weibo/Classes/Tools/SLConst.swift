//
//  SLConst.swift
//  SLTodayNews
//
//  Created by 浮生若梦 on 2016/11/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

// MARK: - 通知
// MARK: - 新特性页通知
public let NewFeatureViewControllerDidFinishedGuide = "NewFeatureViewControllerDidFinishedGuide"
// MARK: - 加载广告页success
public let AdvertiseImageLoadSuccess = "AdvertiseImageLoadSuccess"
// MARK: - 加载广告页失败
public let AdvertiseImageLoadFailure = "AdvertiseImageLoadFailure"
public let AdvertisePushNotification = "AdvertisePushNotification"

/// 屏幕的宽
let SCREENW = UIScreen.main.bounds.size.width
/// 屏幕的高
let SCREENH = UIScreen.main.bounds.size.height

/// RGBA的颜色设置
func SLColor(_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

/// 背景灰色
func SLGlobalColor() -> UIColor {
    return SLColor(245, g: 245, b: 245, a: 1)
}

/// 红色
func SLGlobalRedColor() -> UIColor {
    return SLColor(245, g: 80, b: 83, a: 1.0)
}

/**
 是否新版本
 */
func isNewUpdate() -> Bool {
    // 1. 获取应用程序当前版本
    let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    // 2. 获取沙盒保存的应用程序版本
    let sanboxVersion = UserDefaults.standard.value(forKey: "CFBundleShortVersionString") as? String ?? "0.0"
    // 3. 利用当前版本和沙盒版本比较
    if currentVersion.compare(sanboxVersion) == ComparisonResult.orderedDescending {
        // 3.1如果有新版本, 将新版本保存到偏好设置中
        let defaults = UserDefaults.standard
        defaults.setValue(currentVersion, forKey: "CFBundleShortVersionString")
        // iOS 7.0 之后，就不需要同步了，iOS 6.0 之前，如果不同步不会第一时间写入沙盒
        defaults.synchronize()
        // 4.返回时候有新版本
        return true
    }
    
    return false
}


/// iPhone 5
let isIPhone5 = SCREENH == 568 ? true : false
/// iPhone 6
let isIPhone6 = SCREENH == 667 ? true : false
/// iPhone 6P
let isIPhone6P = SCREENH == 736 ? true : false

