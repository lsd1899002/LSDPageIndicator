//
//  LSDDefaultSlider.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/18.
//  Copyright © 2019 北京鱼爪网络科技有限公司. All rights reserved.
//

import UIKit

class LSDDefaultSlider: UIView {
    
    /// x的坐标
    private var currentX: CGFloat = 0
    
    public convenience init(frame: CGRect, bacColor: UIColor = .black) {
        self.init(frame: frame)
        self.backgroundColor = bacColor
        self.currentX = self.frame.origin.x
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = self.bounds.size.height/2
        self.layer.masksToBounds = true
    }
    
    /// 移动动画
    ///
    /// - Parameters:
    ///   - index: 当前的item的下标
    ///   - offset: 当前的偏移量
    ///   - itemWidth: 需要移动到的view的宽度
    public func move(_ index: Int, _ offset: CGFloat, _ itemWidth: CGFloat) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.frame.origin.x = CGFloat(itemWidth * (CGFloat(index) + offset)) + self.currentX
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
