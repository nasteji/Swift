//
//  Animator.swift
//  VK Client
//
//  Created by Анастасия Живаева on 31.03.2021.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isDismissing: Bool
    
    init(isDismissing: Bool = false) {
        self.isDismissing = isDismissing
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to)
        else { return }
        
        let containerFrame = transitionContext.containerView.frame
        let height = (containerFrame.height - containerFrame.width) / 2
        let width = containerFrame.width + height
            
        let sourceTargetFrame = CGRect(
            x: isDismissing ? width : -width ,
            y: -height,
            width: source.view.frame.width,
            height: source.view.frame.height)
        
        let destinationTargetFrame = CGRect(
            x: -height,
            y: height,
            width: source.view.frame.height,
            height: source.view.frame.width)
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        if isDismissing {
            destination.view.frame = CGRect(
                x: -containerFrame.height,
                y: 0,
                width: source.view.frame.height,
                height: source.view.frame.width)
            destination.view.transform = CGAffineTransform(rotationAngle: .pi / 2)
        } else {
            destination.view.frame = CGRect(
                x: width,
                y: -height,
                width: source.view.frame.width,
                height: source.view.frame.height)
            destination.view.transform = CGAffineTransform(rotationAngle: .pi * 1.5)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: [],
                       animations: {
                        source.view.frame = sourceTargetFrame
                        destination.view.frame = destinationTargetFrame
                        destination.view.transform = .identity
                        if self.isDismissing {
                            source.view.transform = CGAffineTransform(rotationAngle: .pi * 1.5)
                        } else {
                            source.view.transform = CGAffineTransform(rotationAngle: .pi / 2)
                        }
                       },
                       completion: { finished in
                        
                        let finishedAndNotCancelled = finished && !transitionContext.transitionWasCancelled
                        transitionContext.completeTransition(finishedAndNotCancelled)
                       })
    }
    
}
