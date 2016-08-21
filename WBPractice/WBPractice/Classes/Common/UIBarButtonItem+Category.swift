//
//  UIBarButtonItem+Category.swift
//  WBPractice
//
//  Created by xjc on 16/8/21.
//  Copyright © 2016年 xjc. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //在func前加class，相当OC中的＋
    class func createBarButtonItem(imageName: String, target: AnyObject?, action: Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
}
