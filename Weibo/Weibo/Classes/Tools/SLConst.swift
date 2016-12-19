//
//  SLConst.swift
//  SLTodayNews
//
//  Created by 浮生若梦 on 2016/11/10.
//  Copyright © 2016年 Ls. All rights reserved.
//

import UIKit

// MARK: - 封装日志输出方法
//封装的日志输出功能（T表示不指定日志信息参数类型）
func LsLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //打印日志内容
        print("\(fileName):\(line) \(function) | \(message)")
    #endif
}

///  封装的日志输出功能（T表示不指定日志信息参数类型）
///  这里我将日志信息写到应用的 Caches 文件夹中（Library/Caches/log.txt）
///  为了让日志信息更加丰富，再将日志写到文件中时还会附上调用的日期时间。
///  打印日志并写入本地文件 再次重启程序可以查看本地日志
/// - Parameters:
///   - message: 输出文字
///   - file: 文件名
///   - function: 方法名
///   - line: 行号
func DebugLog<T>(_ message:T, file:String = #file, function:String = #function,
           line:Int = #line) {
    #if DEBUG
        //获取文件名
        let fileName = (file as NSString).lastPathComponent
        //日志内容
        let consoleStr = "\(fileName):\(line) \(function) | \(message)"
        //打印日志内容
        print(consoleStr)
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // 使用日期格式器格式化当前日期、时间
        let datestr = dformatter.string(from: Date())
        
        //将内容同步写到文件中去（Caches文件夹下）
        let cachePath = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask)[0]
        let logURL = cachePath.appendingPathComponent("log.txt")
        appendText(fileURL: logURL, string: "\(datestr) \(consoleStr)")
    #endif
}

//在文件末尾追加新内容
func appendText(fileURL: URL, string: String) {
    do {
        //如果文件不存在则新建一个
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            FileManager.default.createFile(atPath: fileURL.path, contents: nil)
        }
        
        let fileHandle = try FileHandle(forWritingTo: fileURL)
        let stringToWrite = "\n" + string
        
        //找到末尾位置并添加
        fileHandle.seekToEndOfFile()
        fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
        
    } catch let error as NSError {
        print("failed to append: \(error)")
    }
}

// MARK: - 应用程序信息
/// 应用程序 ID
let WBAppKey = "1486805696"
/// 应用程序加密信息(开发者可以申请修改)
let WBAppSecret = "ee4d289badb176c371651cd80885b0b7"
/// 回调地址 - 登录完成调转的 URL，参数以 get 形式拼接
let WBRedirectURI = "https://api.weibo.com/oauth2/default.html"

// MARK: - 通知
// MARK: - 用户需要登录通知
public let WBUserShouldLoginNotification = "WBUserShouldLoginNotification"
// MARK: - 用户登录成功通知
public let WBUserLoginSuccessedNotification = "WBUserLoginSuccessedNotification"

// MARK: - 照片浏览通知定义
/// @param selectedIndex    选中照片索引
/// @param urls             浏览照片 URL 字符串数组
/// @param parentImageViews 父视图的图像视图数组，用户展现和解除转场动画参照
/// 微博 Cell 浏览照片通知
let WBStatusCellBrowserPhotoNotification = "WBStatusCellBrowserPhotoNotification"
/// 选中索引 Key
let WBStatusCellBrowserPhotoSelectedIndexKey = "WBStatusCellBrowserPhotoSelectedIndexKey"
/// 浏览照片 URL 字符串 Key
let WBStatusCellBrowserPhotoURLsKey = "WBStatusCellBrowserPhotoURLsKey"
/// 父视图的图像视图数组 Key
let WBStatusCellBrowserPhotoImageViewsKey = "WBStatusCellBrowserPhotoImageViewsKey"

// MARK: - 微博配图视图常量
// 配图视图外侧的间距
let WBStatusPictureViewOutterMargin = CGFloat(12)
// 配图视图内部图像视图的间距
let WBStatusPictureViewInnerMargin = CGFloat(3)
// 视图的宽度的宽度
let WBStatusPictureViewWidth = UIScreen.sl_screenWidth() - 2 * WBStatusPictureViewOutterMargin
// 每个 Item 默认的宽度
let WBStatusPictureItemWidth = (WBStatusPictureViewWidth - 2 * WBStatusPictureViewInnerMargin) / 3


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

// MARK: - 计算多行文本高度
func caculateTextHeight(text: String, viewSize: CGSize, font: UIFont) -> CGFloat {
    return (text as NSString).boundingRect(with: viewSize, options: [.usesLineFragmentOrigin], attributes: [NSFontAttributeName: font], context: nil).height
}
