//
//  LSDInputView.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/18.
//  Copyright © 2019 北京鱼爪网络科技有限公司. All rights reserved.
//

import UIKit

class LSDInputView {
    var datas : [Any]
    
    /// 初始化
    ///
    /// - Parameter datas: 传入一个Any类型数组
    init(datas:[Any]) {
        self.datas = datas
    }
    
    /// 编辑你想要的视图
    ///
    /// - Parameters:
    ///   - temp: Any类型数据源
    ///   - index: 第几个item
    /// - Returns: 返回view
    public func getInputView(_ temp: Any,_ index:Int) -> UIView? {
        return nil
    }
    
    /// 选中状态
    ///
    /// - Parameters:
    ///   - view: 当前view
    ///   - temp: Any类型数据源
    public func select(_ view: UIView, _ temp: Any){
        
    }
    
    /// 未选中状态
    ///
    /// - Parameters:
    ///   - view: 当前view
    ///   - temp: Any类型数据源
    public func unselect(_ view: UIView, _ temp: Any){
        
    }
    
    /// 正在滑动
    ///
    /// - Parameters:
    ///   - view: 当前视图
    ///   - offset: 偏移量
    ///   - temp: Any类型数据源
    public func drag(_ view: UIView, _ offset: CGFloat, _ temp: Any) {
        
    }
}
