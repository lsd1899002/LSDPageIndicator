//
//  ViewController.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/12.
//  Copyright © 2019 ... All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var v1: ViewController1 = {
        let vc = ViewController1()
        vc.view.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        return vc
    }()
    
    private lazy var v2: ViewController2 = {
        let vc = ViewController2()
        vc.view.frame = CGRect(x: 300, y: 0, width: 300, height: 400)
        return vc
    }()
    
    private lazy var v3: ViewController3 = {
        let vc = ViewController3()
        print(self.view.bounds.size.width)
        vc.view.frame = CGRect(x: 600, y: 0, width: 300, height: 400)
        return vc
    }()
    
    private lazy var indicator: LSDPageIndicator = {
        let indicator = LSDPageIndicator(frame: CGRect(x: 50, y: 100, width: 300, height: 50))
        return indicator
    }()
    
    private lazy var scr: UIScrollView = {
        let scroll = UIScrollView(frame: CGRect(x: 50, y: 150, width: 300, height: 400))
        scroll.backgroundColor = .black
        scroll.isPagingEnabled = true
        scroll.contentSize = CGSize(width: 900, height: 400)
        return scroll
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(indicator)
        self.view.addSubview(scr)
        self.addChildViewController(v1)
        self.addChildViewController(v2)
        self.addChildViewController(v3)
        self.scr.addSubview(v1.view)
        self.scr.addSubview(v2.view)
        self.scr.addSubview(v3.view)
        
        let item = MyInput(datas: ["item1","item2","item3"])
        indicator.show(inputView: item, slider: mySlider(), selectedIndex: 2)
        indicator.bindingSV(sv: self.scr)
    }
}


class MyInputBean{
    enum MyInputType {
        case TEXT
        case PIC
    }
    
    var type : MyInputType = .TEXT
    var title: String = ""
    var pic : String = ""
    var select: Bool = false
    
    required init() {}
}

class MyInput: LSDInputView {
    override func getInputView(_ temp: Any, _ index: Int) -> UIView? {
        let view = LSDDefaultView.init(size: CGSize(width: 100, height: 50), normalFont: 14, selectFont: 16, normalColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), selectColor: UIColor(red: 175/255.0, green: 0, blue: 23/255.0, alpha: 1))
        view.frame.origin = CGPoint(x: 100 * index, y: 0)
        view.setTitle(temp as! String)
        return view
    }
    
    override func select(_ view: UIView, _ temp: Any) {
        let view1 = view as! LSDDefaultView
        view1.selectStyle()
    }
    
    override func unselect(_ view: UIView, _ temp: Any) {
        let view1 = view as! LSDDefaultView
        view1.unSelectStyle()
    }
    
    override func drag(_ view: UIView,_ offset: CGFloat, _ temp: Any) {
        let view1 = view as! LSDDefaultView
        view1.dragStyle(offset)
    }
}

class mySlider: LSDSliderView  {
    override func getSlider() -> UIView? {
        return LSDDefaultSlider.init(frame: CGRect(x: 10, y: 0, width: 80, height: 2), bacColor: .red)
    }
    
    override func getPoint() -> LSDSliderView.PositiveType {
        return .BOTTOM
    }
    
    override func move(_ index: Int, _ offset: CGFloat, _ slider: UIView, _ itemWidth: CGFloat) {
        let view = slider as! LSDDefaultSlider
        view.move(index, offset, itemWidth)
    }
}


