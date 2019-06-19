//
//  ViewController1.swift
//  secondScroll
//
//  Created by 罗达达 on 2019/6/12.
//  Copyright © 2019 北京鱼爪网络科技有限公司. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    
    private lazy var label1: UILabel = {
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        label.text = "哈哈"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .purple
        self.view.addSubview(label1)

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
