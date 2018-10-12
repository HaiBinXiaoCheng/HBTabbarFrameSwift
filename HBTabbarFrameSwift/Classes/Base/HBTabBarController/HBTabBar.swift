//
//  HBTabBar.swift
//  HBTabbarFrameSwift
//
//  Created by 彭彬 on 2018/1/19.
//  Copyright © 2018年 PB. All rights reserved.
//

import UIKit

enum HBTabBarUIType: NSInteger {
    case tabBarItemUIType_One   =   1     //底部1个选项
    case tabBarItemUIType_Two   =   2     //底部2个选项
    case tabBarItemUIType_Three =   3     //底部3个选项
    case tabBarItemUIType_Four  =   4     //底部4个选项
    case tabBarItemUIType_Five  =   5     //底部5个选项
}

class HBTabBar: UITabBar {
    
    //tabbar的item个数,根据数组个数计算
    var itemType : HBTabBarUIType?
    var hasCenterItem : Bool = false
    //懒加载中间按钮,不用的时候是不会创建的
    lazy var centerTabBarItem = HBTabBarCenterItem.initializeTabBarCenterItem()
    
    //为了入口的唯一性,将初始化方法重写为私密方法
    private override init(frame: CGRect) {super.init(frame: frame)}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 类方法唯一初始化方法
    ///
    /// - Parameters:
    ///   - type: tabbar的item个数
    ///   - hasCenterItem: 是否展示中间凸出按钮
    /// - Returns: HBTabBar实例
    class func instanceCustomTabBar(type:HBTabBarUIType , hasCenterItem:Bool) -> HBTabBar {
        var barType = type;
        //如果有中间按钮则tabbar的总个数+1
        if hasCenterItem {
            barType = HBTabBarUIType(rawValue: type.rawValue+1)!
        }
        assert(!(barType.rawValue % 2 == 0 && hasCenterItem), "如果含有中间凸出Item的话,必须是奇数个Item,type个数是不包含中间凸出Item的奥")
        let tabBar = HBTabBar.init(type: barType, hasCenterItem: hasCenterItem)
        return tabBar
    }
    //私有初始化方法
    private init(type:HBTabBarUIType , hasCenterItem:Bool) {
        super.init(frame: CGRect.zero)
        self.itemType = type;
        self.hasCenterItem = hasCenterItem;
        self.configCenterItem()
    }
    
    //初始化创建中间按钮
    func configCenterItem() {
        if !self.hasCenterItem {
            return
        }
        self.centerTabBarItem.addTarget(self, action: #selector(centerTabBarItemDidClick(btn:)) , for: UIControlEvents.touchUpInside)
        self.addSubview(self.centerTabBarItem)
    }
    //中间按钮点击事件
    @objc func centerTabBarItemDidClick(btn: HBTabBarCenterItem) {
        print("点击了中间按钮,但是还没有搞代理")
    }
    
    //重新布局TabBarItem位置尺寸
    override func layoutSubviews() {
        super.layoutSubviews()
        if !self.hasCenterItem {
            return
        }
        let itemW: CGFloat = CGFloat(self.frame.size.width) / CGFloat((self.itemType?.rawValue)!)
        let tabBarItemClass: AnyClass = NSClassFromString("UITabBarButton")!
        for view: UIView in self.subviews {
            
            if view.isEqual(self.centerTabBarItem) {
                view.frame = CGRect.init(x: 0, y: 0, width: itemW, height: self.frame.size.height)
                view.sizeToFit()
                view.center = CGPoint.init(x: self.centerX, y: 10)
            }else if view.isKind(of: tabBarItemClass) {
                let frame: CGRect = view.frame
                //防止view: UIView in self.subviews获取到的不是有序的
                var indexFromOrigin: NSInteger = NSInteger(view.frame.origin.x/itemW)
                //如果item的位置在中间按钮的右边,则序号+1
                if indexFromOrigin >= ((self.itemType?.rawValue)! - 1)/2 {
                    indexFromOrigin += 1
                }
                let x: CGFloat = CGFloat(indexFromOrigin) * itemW
                //因为是系统的UITabBarItem,并且有中间按钮,所以调整空间,空出中间按钮位置
                view.frame = CGRect.init(x: x, y: view.frame.origin.y, width: itemW, height: frame.size.height)
            }
        }
    }
    
    
}
