//
//  ViewController.swift
//  QYReversalView
//
//  Created by Joggy on 16/6/19.
//  Copyright © 2016年 Joggy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var reversalView: QYReversalView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        reversalView = QYReversalView(frame: CGRectMake(0, 0, 300, 400))
        reversalView.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        let foreImageView = UIImageView(frame: CGRectMake(0, 0, reversalView.frame.width ,reversalView.frame.height))
        foreImageView.image = UIImage(named: "img")
        reversalView.foreView.layer.cornerRadius = 5
        reversalView.foreView.layer.masksToBounds = true
        reversalView.foreView.addSubview(foreImageView)
        let backImageView = UIImageView(frame: CGRectMake(0, 0, reversalView.frame.width, reversalView.frame.height))
        backImageView.image = UIImage(named: "shirley")
        reversalView.backView.layer.cornerRadius = 5
        reversalView.backView.layer.masksToBounds = true
        reversalView.backView.addSubview(backImageView)
        
        let showButton = UIButton(type: UIButtonType.System)
        showButton.frame = CGRectMake(0, 0, 66, 44)
        showButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height/2)
        showButton.setAttributedTitle(NSAttributedString(string: "show", attributes: [NSForegroundColorAttributeName: UIColor.greenColor()]), forState: UIControlState.Normal)
        showButton.addTarget(self, action: #selector(showReversalView), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(showButton)
    }
    
    func showReversalView() {
        reversalView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

