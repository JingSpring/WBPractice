//
//  VisitorView.swift
//  WBPractice
//
//  Created by xjc on 16/8/19.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

protocol VisitorViewDelegate: NSObjectProtocol {
    //登陆回调
    func loginBtnWillClick()
    //注册回调
    func registerBtnWillClick()
}

class VisitorView: UIView {
    
    //加上weak，避免循环引用
    weak var delegate: VisitorViewDelegate?
    
    /**
     设置未登陆界面
     
     - parameter isHome:    判断是否为首页
     - parameter imageName: 需要展示的图标名称
     - parameter message:   需要展示的文本内容
     */
    func setupVisitorInfo(isHome: Bool, imageName: String, message: String) {
        //不是首页，就隐藏转盘
        iconView.hidden = !isHome
        //修改中间代码
        homeIcon.image = UIImage(named: imageName)
        //修改文本
        messageLabel.text = message
        
        //判断是否需要执行动画
        if isHome {
            
            startAnimation()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化UI
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
 /// 初始化UI
    func setupUI() {
        
        //1.添加子控件
        addSubview(iconView)
        addSubview(homeIcon)
        addSubview(maskBGView)
        addSubview(messageLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        //2.布局子控件
        //2.1设置背景
        iconView.xmg_AlignHorizontal(type: XMG_AlignType.Center, referView: self, size: nil)
        //2.2设置小房子
        homeIcon.xmg_AlignHorizontal(type: XMG_AlignType.Center, referView: self, size: nil)
        //2.3设置文本
        messageLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomCenter, referView: iconView, size: nil)
        
        //item: "哪个控件" 的 attribute: "什么属性" "等于" "另一个控件" 的 "什么属性" 乘与 "多少" 加上 "多少"
        let cons = NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224)
        addConstraint(cons)
        
        //2.4设置按钮
        registerButton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 10))
        
        loginButton.xmg_AlignVertical(type: XMG_AlignType.BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 10))
        
        //2.5设置背景蒙板
        maskBGView.xmg_Fill(self, insets: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
    }
    
    //MARK: - 懒加载控件
    /// 转盘
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        
        return iv
    }()
    // 图标
    private lazy var homeIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return iv
    }()
    /// 文本
    private lazy var messageLabel: UILabel = {
       let label = UILabel()
        label.text = "去注册一下吧，你还没有注册哦！"
        label.numberOfLines = 0
        label.textAlignment = .Center
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    /// 登陆按钮
    private lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("登陆", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: "loginBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    func loginBtnClick() {
//        print(__FUNCTION__)
        
        delegate?.loginBtnWillClick()
    }
    
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: "registerBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    func registerBtnClick() {
//        print(__FUNCTION__)
        
        delegate?.registerBtnWillClick()
    }
    
    //设置蒙板
    private lazy var maskBGView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return iv
    }()
    
    //MARK: - 内部控制方法
    private func startAnimation() {
        //1.创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        //2.设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        //2.1该属性默认为YES，代表动画执行完毕就移除
        anim.removedOnCompletion = false
        //3.将动画添加到图层
        iconView.layer.addAnimation(anim, forKey: nil)
    }

}
