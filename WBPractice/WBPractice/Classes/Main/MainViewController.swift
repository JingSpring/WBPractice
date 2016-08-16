//
//  MainViewController.swift
//  WBPractice
//
//  Created by xjc on 16/8/16.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor.orangeColor()
        
        /*let home = HomeTableViewController()
        home.tabBarItem.image = UIImage(named: "tabbar_home")
        home.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")
        home.title = "首页"
        
        let nav = UINavigationController()
        nav.addChildViewController(home)
        
        addChildViewController(nav)*/
        
        addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
        addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
        addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
        addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        
    }
    /**
     初始化子控制器
     
     - parameter childController: 需要初始化的子控制器
     - parameter title:           子控制器的标题
     - parameter imageName:       子控制器的图片
     */
    private func addChildViewController(childControllerName: String,  title: String, imageName: String) {
        
        //动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        //将字符串转换为类
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        //通过类创建对象
        let vcCls = cls as! UIViewController.Type
        //通过class创建对象
        let vc = vcCls.init()
        
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        vc.title = title
        
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        addChildViewController(nav)
    }

}
