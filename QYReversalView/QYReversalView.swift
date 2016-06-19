//
//  QYReversalView.swift
//  QYReversalView
//
//  Created by Joggy on 16/6/19.
//  Copyright © 2016年 Joggy. All rights reserved.
//

import UIKit

class QYReversalView: UIView {
    
    var foreView: UIView!
    var backView: UIView!
    
    private var bottomView: UIView!
    private var shadowView: UIView!
    private var isTurnBack: Bool = false
    private var panStartLocation = CGPointZero
    private var angle: CGFloat = 0
    private var viewTransform: CATransform3D!
    
    private let screenWidth = UIScreen.mainScreen().bounds.width
    private let screenHeight = UIScreen.mainScreen().bounds.height

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareForLayout()
    }
    
    private func prepareForLayout() {
        bottomView = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        bottomView.backgroundColor = UIColor.clearColor()
        foreView = UIView(frame: CGRectMake(0, 0, frame.width, frame.height
            ))
        bottomView.addSubview(foreView)
        backView = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        backView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
        bottomView.insertSubview(backView, belowSubview: foreView)
        self.addSubview(bottomView)
        shadowView = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        shadowView.backgroundColor = UIColor.blackColor()
        shadowView.alpha = 0.7
        viewTransform = CATransform3DIdentity
        let tapDismiss = UITapGestureRecognizer()
        tapDismiss.addTarget(self, action: #selector(dismiss))
        shadowView.addGestureRecognizer(tapDismiss)
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(rotateWithPan(_:)))
        self.addGestureRecognizer(pan)
        self.backgroundColor = UIColor.clearColor()
    }
    
    func show() {
        let superWindow = UIApplication.sharedApplication().keyWindow!
        superWindow.addSubview(shadowView)
        superWindow.addSubview(self)
        self.transform = CGAffineTransformMakeScale(0.5, 0.5)
        self.alpha = 0
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.transform = CGAffineTransformMakeScale(1, 1)
            self.alpha = 1
            }, completion: nil)
    }
    
    func dismiss() {
        shadowView.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    func rotateWithPan(panGesture: UIPanGestureRecognizer) {
        let status = panGesture.state
        let location = panGesture.translationInView(self)
        switch status {
        case .Began:
            panStartLocation = location
            break
        case .Changed:
            angle = (location.x - panStartLocation.x)*CGFloat(M_PI*2)/frame.width
            viewTransform = CATransform3DIdentity
            viewTransform.m34 = -1.5/2500.0
            viewTransform = CATransform3DRotate(viewTransform, angle, 0, 1, 0)
            bottomView.layer.transform = viewTransform
            if shouldTurnBackViewToFont(angle) {
                bottomView.bringSubviewToFront(backView)
            }
            else {
                bottomView.bringSubviewToFront(foreView)
            }
            break
        case .Ended:
            viewTransform = CATransform3DIdentity
            bottomView.layer.transform = viewTransform
            if shouldTurnBackViewToFont(angle) {
                isTurnBack = true
                foreView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
                backView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI*2), 0, 1, 0)
            }
            else {
                isTurnBack = false
                foreView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI*2), 0, 1, 0)
                backView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 0, 1, 0)
            }
            break
        default:
            break
        }
    }
    
    private func shouldTurnBackViewToFont(angle: CGFloat) -> Bool {
        let an = abs(angle%CGFloat(M_PI*2))
        if isTurnBack {
            if an >= 0 && an < CGFloat(M_PI_2) || an >= CGFloat(M_PI*3/2) && an < CGFloat(M_PI*2) {
                return true
            }
            else {
                return false
            }
        }
        else {
            if an >= 0 && an < CGFloat(M_PI_2) || an >= CGFloat(M_PI*3/2) && an < CGFloat(M_PI*2) {
                return false
            }
            else {
                return true
            }
        }
    }
    
    private func delay(time: Double, closure: ()->()){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time*Double(NSEC_PER_SEC))), dispatch_get_main_queue(), closure)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
