//
//  HamburgerViewController.swift
//  Hamburger Menu Demo
//
//  Created by Timothy Lee on 9/18/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    var initialLeftMargin: CGFloat!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var menuViewController: UIViewController? {
        didSet(oldMenuViewController) {
//            if menuViewController != nil {
//                menuViewController!.willMoveToParentViewController(nil)
//                menuViewController!.view.removeFromSuperview()
//                menuViewController!.removeFromParentViewController()
//            }
//            
//            if newMenuViewController != nil {
//                newMenuViewController!.willMoveToParentViewController(self)
//                menuView.addSubview(newMenuViewController!.view)
//                newMenuViewController!.view.frame = menuView.bounds
//                newMenuViewController!.didMoveToParentViewController(self)
//            }
            
            view.layoutIfNeeded()
            
            // Simple version
            menuView.addSubview(menuViewController!.view)
            menuViewController!.view.frame = menuView.bounds
        }
    }
    
    var contentViewController: UIViewController? {
        didSet {
            contentViewController!.view.frame = contentView.bounds
            contentView.addSubview(contentViewController!.view)
            contentView.layoutIfNeeded()
            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.leftConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            initialLeftMargin = leftConstraint.constant
        } else if sender.state == UIGestureRecognizerState.Changed {
            leftConstraint.constant = initialLeftMargin + translation.x
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                if velocity.x > 0 {
                    self.leftConstraint.constant = self.view.frame.size.width - 50
                } else {
                    self.leftConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
