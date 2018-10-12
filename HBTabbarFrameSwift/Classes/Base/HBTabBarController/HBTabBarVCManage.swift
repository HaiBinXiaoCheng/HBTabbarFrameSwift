//
//  HBTabBarVCManage.swift
//  HBTabbarFrameSwift
//
//  Created by 彭彬 on 2018/1/19.
//  Copyright © 2018年 PB. All rights reserved.
//

import UIKit

let kTabBarTitle            = "tabTitle"
let kTabBarClassName        = "className"
let kTabBarDefaultImage     = "defaultImage"
let kTabBarSelectedImage    = "selectedImage"
let kTabBarIsSelected       = "isSelected"

struct HBTabBarItemProperty {
    //tab的Title
    var tabTitle: String?
    //tab上对应VC控制器的类名
    var className: String?
    //tab的默认图片
    var defaultImage: String?
    //tab的选中图片
    var selectedImage: String?
    //tab的是否被选中
    var isSelected: Bool?
    
    init(controllersInfo dic : Dictionary<String, Any>) {
        tabTitle        = dic[kTabBarTitle] as? String
        className       = dic[kTabBarClassName] as? String
        defaultImage    = dic[kTabBarDefaultImage] as? String
        selectedImage   = dic[kTabBarSelectedImage] as? String
        isSelected      = dic[kTabBarIsSelected] as? Bool
    }
}

class HBTabBarVCManage: NSObject {

    func configTabBarController() -> HBTabBarController {
        
        let path: String = Bundle.main.path(forResource: "HBTabBarConfig", ofType: "plist")!
        let allTabs = NSArray.init(contentsOfFile: path)
        let tabsPropertyArr: NSArray = NSArray()
        var selectedIndex: NSInteger = 0
        for index in 0..<(allTabs?.count)! {
            let tabBeanDic: NSDictionary = allTabs![index] as! NSDictionary
            let property = HBTabBarItemProperty.init(controllersInfo: tabBeanDic as! Dictionary<String, Any>)
            tabsPropertyArr.adding(property)
            if property.isSelected! {
                selectedIndex = index
            }
        }
        let tabBarVC = HBTabBarController.init(tabBarItems: tabsPropertyArr as! Array<Any>)
        tabBarVC.selectedIndex = selectedIndex;
        return tabBarVC;
    }
    
}
