//
//  LSDSliderView.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/18.
//  Copyright © 2019 北京鱼爪网络科技有限公司. All rights reserved.
//

import UIKit

class LSDSliderView {
    
    enum PositiveType {
        case TOP //顶部
        case MIDDLE //中部
        case BOTTOM //底部
    }
    
    /// 编辑你想要的滑块
    ///
    /// - Returns: 返回UIView
    public func getSlider() -> UIView? {
        return nil
    }
    
    /// 滑块的相对位置
    ///
    /// - Returns: 位置
    public func getPoint() -> PositiveType {
        return PositiveType.TOP
    }
    
    /// 移动（自己写动画移动）
    ///
    /// - Parameters:
    ///   - index: 需要移动的item的小标
    ///   - offset: 相对偏移量(0-1)
    ///   - slider: 滑块
    ///   - itemWidth: 当前滑块的宽度
    public func move(_ index: Int,_ offset: CGFloat, _ slider: UIView, _ itemWidth: CGFloat) {
        
    }
}
