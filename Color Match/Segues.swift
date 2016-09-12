//
//  SegueFromLeft.swift
//  Color Match
//
//  Created by RB Embleton on 9/9/16.
//  Copyright © 2016 RB Embleton. All rights reserved.
//

import UIKit

class SegueFromLeft: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0)
        
        UIView.animate(withDuration: 1,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveLinear,
                                   animations: {
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                                    src.view.transform = CGAffineTransform(translationX: 2 * src.view.frame.size.width, y: 0)
            },
                                   completion: { finished in
                                    src.present(dst, animated: false, completion: nil)
            }
        )
    }
}

class SegueFromRight: UIStoryboardSegue
{
    override func perform()
    {
        let src = self.source
        let dst = self.destination
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: 2 * src.view.frame.size.width, y: 0)
        src.view.transform = CGAffineTransform(translationX: 0, y: 0)
        
        UIView.animate(withDuration: 1,
                                   delay: 0.0,
                                   options: UIViewAnimationOptions.curveLinear,
                                   animations: {
                                    dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
                                    src.view.transform = CGAffineTransform(translationX: -1.0 * src.view.frame.size.width, y: 0)
            },
                                   completion: { finished in
                                    src.present(dst, animated: false, completion: nil)
            }
        )
    }
}

class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
        ) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(
        using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        _ = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(
            forKey: UITransitionContextViewControllerKey.to)
        
        containerView.addSubview(toVC!.view)
        toVC!.view.alpha = 0.0
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toVC!.view.alpha = 1.0
            }, completion: { finished in
                let cancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!cancelled)
        })
    }

}

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation:
        UINavigationControllerOperation,
                                        from fromVC: UIViewController,
                                                           to toVC: UIViewController
        ) -> UIViewControllerAnimatedTransitioning? {
        
        return FadeInAnimator()
    }
}


