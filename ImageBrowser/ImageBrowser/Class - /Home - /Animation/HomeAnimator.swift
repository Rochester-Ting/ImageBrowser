//
//  HomeAnimator.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit
protocol presentAnimationDelegate : NSObjectProtocol{
    // 做弹出动画的视图
    func presentAnimationView() -> UIView
    // 弹出动画的开始位置
    func presentAnimationFromFrame() -> CGRect
    // 弹出动画结束的位置
    func presentAnimationToFrame() -> CGRect
    
 }
protocol dismissAnimationDelegate : NSObjectProtocol{
    // 做消失动画的视图
    func dismissAnimationView() -> UIView
    // 消失动画的开始位置
    func dismissAnimationFromFrame() -> CGRect
    // 消失动画结束的位置
    func dismissAnimationToFrame() -> CGRect
    
}
class HomeAnimator: NSObject,UIViewControllerTransitioningDelegate {
    weak var presentDelegate : presentAnimationDelegate?
    weak var dismissDelegate : dismissAnimationDelegate?
    var isPresent : Bool = true
    // present动画谁来做
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
//     dismiss动画谁来做
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
}
extension HomeAnimator : UIViewControllerAnimatedTransitioning{
    // 动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    // 动画具体执行
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent { // 执行present动画
            presentAnimation(transitionContext: transitionContext)
        }else{ // 执行dismiss动画
            dissmissAnimation(transitionContext: transitionContext)
        }
        
    }
    func dissmissAnimation(transitionContext: UIViewControllerContextTransitioning){
        // 包含的view
        let containerView = transitionContext.containerView
        // fromView
        let fromView = transitionContext.view(forKey: .from)
        // toView
//        let toView = transitionContext.view(forKey: .to)
        // 取出代理
        guard let dD = dismissDelegate else {
            return
        }
        fromView?.alpha = 0
        // 1.做动画的视图
        let dismissView = dD.dismissAnimationView()
        // 2.动画的起始位置
        let dismissFromFrame = dD.dismissAnimationFromFrame()
        // 3.动画结束的位置
        let dismissToFrame = dD.dismissAnimationToFrame()
        
        // 添加做动画的视图
        containerView.addSubview(dismissView)
        
        // 添加最终的view
//        toView?.frame = ScreenBounds
//        toView?.alpha = 0
//        containerView.addSubview(toView!)
        
        // 设置做动画的frame
        dismissView.frame = dismissFromFrame
        
        UIView.animate(withDuration: 0.5, animations: {
            dismissView.frame = dismissToFrame
            
        }) { (complete) in
            fromView?.removeFromSuperview()
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        
    }
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning){
        // 包含的view
        let containerView = transitionContext.containerView
        // fromView
        //        let fromView = transitionContext.view(forKey: .from)
        // toView
        let toView = transitionContext.view(forKey: .to)
        
        
        // 取出代理
        guard let pD = presentDelegate else {
            return
        }
        // 1.做动画的视图
        let presentView = pD.presentAnimationView()
        // 2.动画的起始位置
        let presentFromFrame = pD.presentAnimationFromFrame()
        // 3.动画结束的位置
        let presentToFrame = pD.presentAnimationToFrame()
        
        // 添加做动画的视图
        containerView.addSubview(presentView)
        
        // 添加最终的view
        toView?.frame = ScreenBounds
        toView?.alpha = 0
        containerView.addSubview(toView!)
        
        // 设置做动画的frame
        presentView.frame = presentFromFrame
        
        UIView.animate(withDuration: 0.5, animations: {
            presentView.frame = presentToFrame
            
        }) { (complete) in
            toView?.alpha = 1
            presentView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }

    }
}
