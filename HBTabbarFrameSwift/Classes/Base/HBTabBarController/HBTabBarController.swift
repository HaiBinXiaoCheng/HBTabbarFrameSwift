//
//  HBTabBarController.swift
//  HBTabbarFrameSwift
//
//  Created by 彭彬 on 2018/1/19.
//  Copyright © 2018年 PB. All rights reserved.
//

import UIKit

class HBTabBarController: UITabBarController {

    var tabBarItems = Array<HBTabBarItemProperty>();
    
    init(tabBarItems : Array<HBTabBarItemProperty>) {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItems = tabBarItems;
        self.configUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //初始化UI
    func configUI() -> Void {
        
        //KVO方式添加自定义的TabBar
        let tab = HBTabBar.instanceCustomTabBar(type: HBTabBarUIType(rawValue: self.tabBarItems.count)!, hasCenterItem: true)
        tab.delegate = self;
        self.setValue(tab, forKey:"tabBar")
        //初始化子控制器
        self.configChildVC()
    }
    //初始化子控制器
    func configChildVC() {
        for tabBarItem: HBTabBarItemProperty in self.tabBarItems {
            //转变字符串为控制器class
            let ChildController = NSClassFromString(tabBarItem.className!) as! HBViewController.Type
            //初始化控制器
            let childVC: HBViewController = ChildController.init()
            //设置普通默认图片
            childVC.tabBarItem.image = UIImage.init(contentsOfFile: tabBarItem.defaultImage!)
            //初始化被选中样式并且设置禁止图片渲染
            childVC.tabBarItem.selectedImage = UIImage.init(contentsOfFile: tabBarItem.selectedImage!)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
            childVC.tabBarItem.title = tabBarItem.tabTitle!
            //设置title文字样式
            childVC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.gray], for: UIControlState.normal)
            childVC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.orange], for: UIControlState.selected)
            //为子控制器增加导航
            let navi = HBNavigationController.init(rootViewController: childVC)
            self.addChildViewController(navi)
        }
    }
    
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
