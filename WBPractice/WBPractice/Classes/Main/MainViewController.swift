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
        
        //添加所有子控制器
        addChildViewControllers()
        
    }
    //IOS后不推荐在viewDidLoad设置frame
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //添加加号按钮
        setupCompseBtn()
        
    }
    /**
     监听加号按钮点击
     监听按钮点击的方法不能是私有方法
     按钮点击事件的调用是由 运行循环 监听并且以消息机制传递的，因此，按钮监听函数不能设置为 private
     */
    func composeBtnClick() {
        print(__FUNCTION__)
    }
    
    //添加加号按钮
    private func setupCompseBtn() {
        //添加加号按钮
        tabBar.addSubview(composeBtn)
        //调整加号按钮的位置
        let width = UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x: 0, y: 0, width: width, height: 48)
        
        //第一个参数：frame的大小
        //第二个参数：x方向偏移量的大小
        //第三个参数：y方向偏移量的大小
        composeBtn.frame = CGRectOffset(rect, 2 * width, 0)
    }
    
    //MARK:  - 添加所有子控制器
    func addChildViewControllers() {
        //获取json文件路径（可以通过服务器更改控制器数据）
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        //通过文件路径创建NSData
        if let jsonPath = path {
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do {
                //序列化json数据 --> Array
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                //遍历数组，动态创建控制器和设置数据
                for dict in dictArr as! [[String: String]]{
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
                
            }catch{
                //如果json文件动态加载控制器出错，则默认为本地创建
                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                
                //添加一个占位控制器
                addChildViewController("NullViewController", title: "", imageName: "")
                
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            }
        }
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
    
    //MARK: - 懒加载
    private lazy var composeBtn:UIButton = {
        
        let btn = UIButton()
        //添加前景图片
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        //添加背景图片
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.addTarget(self, action: "composeBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()

}
