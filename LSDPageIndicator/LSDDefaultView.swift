//
//  LSDDefaultView.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/18.
//  Copyright © 2019 ... All rights reserved.
//

import UIKit
class LSDDefaultView: UIView {
    
    /// label的文字大小（普通）
    private var nFont: CGFloat = 0
    /// label的文字大小（被选中）
    private var sFont: CGFloat = 0
    /// label的文字颜色 (普通)
    private var nColor: UIColor?
    /// label的文字颜色 （被选中）
    private var sColor: UIColor?
    
    /// 标题
    private lazy var headLine: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        label.backgroundColor = .clear
        return label
    }()
    
    /// 初始化方法
    ///
    /// - Parameters:
    ///   - size: view的size
    ///   - normalFont: label的文字大小（普通）
    ///   - selectFont: label的文字大小（被选中
    ///   - normalColor: label的文字颜色 (普通)
    ///   - selectColor: label的文字颜色 （被选中）
    public convenience init(size: CGSize, normalFont: CGFloat = 12, selectFont: CGFloat = 15, normalColor: UIColor = .white, selectColor: UIColor = .black) {
        self.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.initHeadLine(normalFont: normalFont, selectFont: selectFont, normalColor: normalColor, selectColor: selectColor)
    }

    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.headLine)
    }
    
    private func initHeadLine(normalFont: CGFloat, selectFont: CGFloat, normalColor: UIColor, selectColor: UIColor) {
        self.headLine.textColor = normalColor
        self.headLine.textAlignment = .center
        self.headLine.font = UIFont.systemFont(ofSize: normalFont)
        self.nFont = normalFont
        self.sFont = selectFont
        self.nColor = normalColor
        self.sColor = selectColor
    }
    
    /// 选中状态
    public func selectStyle() {
        self.headLine.textColor = self.sColor
        self.headLine.font = UIFont.systemFont(ofSize: self.sFont)
    }
    
    /// 未选中状态
    public func unSelectStyle() {
        self.headLine.textColor = self.nColor
        self.headLine.font = UIFont.systemFont(ofSize: self.nFont)
    }
    
    /// 拖拽时候的状态
    ///
    /// - Parameter offset: 拖拽的偏移量
    public func dragStyle(_ offset: CGFloat) {
        print(offset)
        guard offset >= 0 && offset <= 1 else {
            return
        }
        UIView.animate(withDuration: 0.1) {
            self.headLine.font = UIFont.systemFont(ofSize: self.nFont + (self.sFont - self.nFont) * offset)
            self.headLine.textColor = self.evaluate(fraction: offset, startValue: self.nColor!, endValue: self.sColor!)
        }
    }
    
    /// 设置标题的text
    ///
    /// - Parameter text: 文字
    public func setTitle(_ text: Any) {
        self.headLine.text = text as? String
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 文字变色
    ///
    /// - Parameters:
    ///   - fraction: 偏移量
    ///   - startValue: 开始颜色
    ///   - endValue: 结束颜色
    /// - Returns: 最终颜色
    public func evaluate(fraction: CGFloat, startValue: UIColor, endValue: UIColor) -> UIColor{
        // convert from sRGB to linear
        let comp1 = startValue.cgColor.components
        let comp2 = endValue.cgColor.components
        
        let startR = CGFloat(pow(comp1![0], 2.2))
        let startG = CGFloat(pow(comp1![1], 2.2))
        let startB = CGFloat(pow(comp1![2], 2.2))
        let startA = CGFloat(pow(comp1![3], 2.2))
        
        let endR = CGFloat(pow(comp2![0], 2.2))
        let endG = CGFloat(pow(comp2![1], 2.2))
        let endB = CGFloat(pow(comp2![2], 2.2))
        let endA = CGFloat(pow(comp2![3], 2.2))
        
        // compute the interpolated color in linear space
        var a = startA + fraction * (endA - startA);
        var r = startR + fraction * (endR - startR);
        var g = startG + fraction * (endG - startG);
        var b = startB + fraction * (endB - startB);
        
        // convert back to sRGB in the [0..255] range
        a = CGFloat(pow(a, 1.0 / 2.2))
        r = CGFloat(pow(r, 1.0 / 2.2))
        g = CGFloat(pow(g, 1.0 / 2.2))
        b = CGFloat(pow(b, 1.0 / 2.2))
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}


