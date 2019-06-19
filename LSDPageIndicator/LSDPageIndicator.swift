//
//  LSDPageIndicator.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/14.
//  Copyright © 2019 ... All rights reserved.
//

import UIKit

class LSDPageIndicator: UIView {
    
    enum DirectionType {
        case Horizontal //横向
        case Vertical //纵向
    }
    
    private var callBack: ((Int) -> ())?
    
    /// 传入的item的类
    private var input: LSDInputView?
    
    /// 传入的下标的类
    private var lsdSlider: LSDSliderView?
    
    /// 传入的滑块
    private var slider: UIView = UIView()
    
    /// 选中的item的下标
    private var selectIndex: Int = 0
    
    /// 内容的总宽度
    private var totalWidth: CGFloat = 0
    
    /// 绑定的滚动视图
    private var subSV : UIScrollView? = nil
    
    /// 绑定的滚顶视图的滚动方向
    private var subSVDirction: DirectionType = .Horizontal

    /// 当前的移动距离
    private var currentOffset: CGFloat = 0
    
    /// 是否开始滑动
    private var beginScroll: Bool = false
    
    /// 当前item的uiview放置的滚动视图
    private lazy var mainSV: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = .white
        return scroll
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(mainSV)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 外部调用的set方法
    ///
    /// - Parameters:
    ///   - inputView: 传入item的父类
    ///   - slider: 传入的滑块的父类
    ///   - selectedIndex: 选中的item的下标
    public func show(inputView: LSDInputView, slider: LSDSliderView, selectedIndex: Int = 0) {
        self.setInput(inputView)
        self.setSlider(slider, selectedIndex)
    }
    
    /// 设置传入的view
    ///
    /// - Parameter inputView: LSDInputView
    private func setInput(_ inputView: LSDInputView) {
        self.input = inputView
        var index = 0
        self.input?.datas.forEach({ (it) in
            let view = self.input?.getInputView(it, index)
            //添加到父布局
            view?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(pageOnClick(_:)))
            //添加点击手势
            view?.addGestureRecognizer(tap)
            view?.tag = 100 + index
            self.mainSV.addSubview(view!)
            index += 1
            self.totalWidth += (view?.bounds.size.width)!
        })
        //设置滚动视图的内容宽度
        self.mainSV.contentSize = CGSize(width: self.totalWidth, height: self.bounds.size.height)
    }
    
    /// 设置传入的滑块
    ///
    /// - Parameters:
    ///   - slider: 滑块
    ///   - selectorIndex: 当前点击的下标
    private func setSlider(_ slider: LSDSliderView, _ selectorIndex: Int) {
        self.lsdSlider = slider
        self.slider = slider.getSlider()!
        switch slider.getPoint() {
        case .TOP:
            self.slider.frame = CGRect(x: self.slider.frame.origin.x, y: 0, width: self.slider.bounds.size.width, height: self.slider.bounds.size.height)
        case .BOTTOM:
            self.slider.frame = CGRect(x: self.slider.frame.origin.x, y: self.mainSV.bounds.size.height - self.slider.bounds.size.height, width: self.slider.bounds.size.width, height: self.slider.bounds.size.height)
        case .MIDDLE:
            self.slider.frame = CGRect(x: self.slider.frame.origin.x, y: self.mainSV.bounds.size.height/2 - (self.slider.bounds.size.height)/2, width: self.slider.bounds.size.width, height: self.slider.bounds.size.height)
        }
        self.isSelectIndex(selectorIndex)
        self.mainSV.layer.insertSublayer(self.slider.layer, at: 0)
    }
    
    /// 点击某个uiview
    ///
    /// - Parameter index: 下标
    private func isSelectIndex(_ index: Int) {
        let view: UIView = self.viewWithTag(index + 100) as! UIView
        self.input?.select(view, self.input?.datas[index])
        if self.selectIndex != index {
            let view1: UIView = self.viewWithTag(self.selectIndex + 100) as! UIView
            self.input?.unselect(view1, self.input?.datas[self.selectIndex])
            self.lsdSlider?.move(index, 0, self.slider, view1.bounds.size.width)
        }
        self.selectIndex = index
        
        guard self.subSV != nil else {
            return
        }
        
        switch self.subSVDirction {
        case .Horizontal:
            self.subSV?.setContentOffset(CGPoint(x: (self.subSV?.bounds.size.width)! * CGFloat(index), y: 0), animated: true)
        case .Vertical:
            self.subSV?.setContentOffset(CGPoint(x: 0, y: (self.subSV?.bounds.size.height)! * CGFloat(index)), animated: true)
        }
    }
    
    /// 设置选中的item
    ///
    /// - Parameter index: 下标
    public func setSelectIndex(_ index: Int) {
        guard self.input != nil else {
            return
        }
        
        self.isSelectIndex(index)
    }
    
    /// 绑定外部的滚动视图（只能绑定开启分页的滚动视图）
    ///
    /// - Parameters:
    ///   - sv: 目标ScrollView
    ///   - direct: 方向
    public func bindingSV(sv:UIScrollView, direct: DirectionType = .Horizontal){
        subSV = sv
        subSV?.delegate = self
        subSVDirction = direct
        self.isSelectIndex(self.selectIndex)
    }
    
    /// 选中按钮的回调
    ///
    /// - Parameter it: 闭包
    public func selectCallBack(_ it: @escaping((Int) -> ())) {
        callBack = it
    }
}

// MARK: - 点击事件
extension LSDPageIndicator {
    @objc private func pageOnClick(_ tap: UITapGestureRecognizer) {
        let index = (tap.view?.tag)! - 100
        let view: UIView = self.viewWithTag(self.selectIndex + 100) as! UIView
        self.input?.unselect(view, self.input?.datas[self.selectIndex])
        self.input?.select(tap.view!, self.input?.datas[index])
        self.lsdSlider?.move(index, 0,self.slider, (tap.view?.bounds.size.width)!)
        self.selectIndex = index
        self.callBack?(index)
        switch self.subSVDirction {
        case .Horizontal:
            self.subSV?.setContentOffset(CGPoint(x: (self.subSV?.bounds.size.width)! * CGFloat(index), y: 0), animated: true)
        case .Vertical:
            self.subSV?.setContentOffset(CGPoint(x: 0, y: (self.subSV?.bounds.size.height)! * CGFloat(index)), animated: true)
        }
    }
}

// MARK: - UIScrollViewDelegate
extension LSDPageIndicator: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("正在滑动")
        guard self.beginScroll == true else {
            return
        }
        switch self.subSVDirction {
        case .Horizontal:
            let frist = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
            let second = Int(scrollView.contentOffset.x/scrollView.bounds.size.width) + 1
            let fristFloat = 1 - (scrollView.contentOffset.x - CGFloat(frist)*scrollView.bounds.size.width)/scrollView.bounds.size.width
            let secondFloat = (scrollView.contentOffset.x - CGFloat(frist)*scrollView.bounds.size.width)/scrollView.bounds.size.width
            guard (self.input?.datas.count)! - 1 >= second && frist >= 0 else {
                return
            }
            
            let view1 = self.viewWithTag(frist + 100) as! UIView
            let view2 = self.viewWithTag(second + 100) as! UIView
            
            self.input?.drag(view1, fristFloat, self.input?.datas[frist] as Any)
            self.input?.drag(view2, secondFloat, self.input?.datas[second])
            if scrollView.contentOffset.x > self.currentOffset {
                self.lsdSlider?.move(frist, secondFloat, self.slider, view2.bounds.size.width)
            } else {
                self.lsdSlider?.move(second, -fristFloat, self.slider, view1.bounds.size.width)
            }
        case .Vertical:
            let frist = Int(scrollView.contentOffset.y/scrollView.bounds.size.height)
            let second = Int(scrollView.contentOffset.y/scrollView.bounds.size.height) + 1
            let fristFloat = 1 - (scrollView.contentOffset.y - CGFloat(frist)*scrollView.bounds.size.height)/scrollView.bounds.size.height
            let secondFloat = (scrollView.contentOffset.y - CGFloat(frist)*scrollView.bounds.size.height)/scrollView.bounds.size.height
            guard (self.input?.datas.count)! - 1 >= second && frist >= 0 else {
                return
            }
            let view1 = self.viewWithTag(frist + 100) as! UIView
            let view2 = self.viewWithTag(second + 100) as! UIView
            self.input?.drag(view1, fristFloat, self.input?.datas[frist] as Any)
            self.input?.drag(view2, secondFloat, self.input?.datas[second])
            if scrollView.contentOffset.y > self.currentOffset {
                self.lsdSlider?.move(frist, secondFloat, self.slider, view2.bounds.size.width)
            } else {
                self.lsdSlider?.move(second, -fristFloat, self.slider, view1.bounds.size.width)
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("将要开始拖拽")
        self.beginScroll = true
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print("已经停止拖拽")
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        print("停止滑动")
        self.beginScroll = false
        switch self.subSVDirction {
        case .Horizontal:
            self.isSelectIndex(Int(scrollView.contentOffset.x/scrollView.bounds.size.width))
            self.currentOffset = scrollView.contentOffset.x
        case .Vertical:
            self.isSelectIndex(Int(scrollView.contentOffset.y/scrollView.bounds.size.height))
            self.currentOffset = scrollView.contentOffset.y
        }
    }
}
