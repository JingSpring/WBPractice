//
//  BaseTableViewController.swift
//  WBPractice
//
//  Created by xjc on 16/8/19.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,VisitorViewDelegate {
    
    //定义一个变量判断用户当前是否登陆
    var userLogin = false
    //保存未登陆界面
    var visitorView: VisitorView?
    
    override func loadView() {
        
        //判断是否登陆
        userLogin ? super.loadView() : setVisitorView()
        
    }
    //MARK: - 内部控制方法
    /**
     创建未登陆界面
     */
    private func setVisitorView() {
        //1.初始化未登陆界面
        let customView = VisitorView()
        customView.delegate = self
        view = customView
        visitorView = customView
        
        //2.设置导航条未登陆按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "registerBtnWillClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: "loginBtnWillClick")
    }
    
    //MARK: - VisitorViewDelegate
    func loginBtnWillClick() {
        print(__FUNCTION__)
    }
    func registerBtnWillClick() {
        print(__FUNCTION__)
    }

}
