
//
//  JoystickView.swift
//  NeverGoneBot-iOS
//
//  Created by Aadesh Patel on 2/7/16.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

class JoystickView: UIView {
    var handleView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.baseInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.baseInit()
    }

    private func baseInit() {
        self.backgroundColor = UIColor.lightGrayColor()
        
        self.handleView = UIView(frame: CGRectMake(CGRectGetMidX(self.bounds) - (self.bounds.size.width / 6.0), CGRectGetMidY(self.bounds) - (self.bounds.size.height / 6.0), self.bounds.size.width / 3.0, self.bounds.size.height / 3.0))
        self.handleView.layer.cornerRadius = self.handleView.frame.size.width / 2.0
        self.handleView.backgroundColor = UIColor.grayColor()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("dragHandleView:"))
        self.handleView.userInteractionEnabled = true
        self.handleView.addGestureRecognizer(panGesture)
        
        self.addSubview(self.handleView)
    }
    
    var animator: UIDynamicAnimator!
    @IBAction func dragHandleView(gesture: UIPanGestureRecognizer) {
        if (gesture.state == .Cancelled ||
            gesture.state == .Failed ||
            gesture.state == .Ended) {
            self.animator = UIDynamicAnimator(referenceView: self)
            let snap = UISnapBehavior(item: self.handleView, snapToPoint: CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)))
            snap.damping = 0.7
            animator.addBehavior(snap)
            //animator.removeAllBehaviors()
            return
        }
        
        let translation = gesture.translationInView(self)
        
        let newX = gesture.view!.center.x + translation.x
        let newY = gesture.view!.center.y + translation.y
        
        if (!(pow(newX - CGRectGetMidX(self.bounds), 2) + pow(newY - CGRectGetMidY(self.bounds), 2) < pow(self.bounds.size.width / 2.0, 2))) {
            return
        }
        
        gesture.view!.center = CGPointMake(newX, newY)
        gesture.setTranslation(CGPointZero, inView: self)
    }
}
