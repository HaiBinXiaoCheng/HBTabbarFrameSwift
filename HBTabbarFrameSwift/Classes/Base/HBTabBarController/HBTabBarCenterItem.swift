//
//  HBTabBarCenterItem.swift
//  HBTabbarFrameSwift
//
//  Created by 彭彬 on 2018/1/23.
//  Copyright © 2018年 PB. All rights reserved.
//

import UIKit

class HBTabBarCenterItem: UIButton {

    class func initializeTabBarCenterItem() -> HBTabBarCenterItem {
        
        let tabBarItem = HBTabBarCenterItem.init(type: .custom)
        tabBarItem.setImage(UIImage.init(named: "tab_scan"), for: .normal)
        tabBarItem.setImage(UIImage.init(named: "tab_scan_pressed") , for: .selected)
        return tabBarItem
    }

}
