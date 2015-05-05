//
//  NamePushTransitionController.swift
//  ios-components
//
//  Created by Amir Rezvani on 4/20/15.
//  Copyright (c) 2015 Jogabo. All rights reserved.
//

import UIKit

//handles transition for push controller
class PushTransitionController : NSObject {
  let duration = 1.0
}


//extension class that conforms to transitioning protocol
//MARK:- UIViewControllerAnimatedTransitioning implementation
extension PushTransitionController : UIViewControllerAnimatedTransitioning {
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return duration
  }

  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

    //1. obtain state from context
    let fromVc = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UINavigationController).viewControllers[0] as! ContactDetailsController
    let toVc = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! AboutYouController
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let finalFrame = transitionContext.finalFrameForViewController(toVc)


    //2. obtain the container
    let containerView = transitionContext.containerView()


    //3. setup transforms for animation
    let offsetRight = CGAffineTransformMakeTranslation(CGRectGetWidth(containerView.bounds), 0)
    let offsetLeft = CGAffineTransformMakeTranslation(-CGRectGetWidth(containerView.bounds), 0)

    toVc.view.layoutIfNeeded()

    //4. setup initial state for views
    containerView.addSubview(fromView)
    containerView.addSubview(toView)
    fromView.center = containerView.center

    toView.transform = offsetRight
    toVc.avatar.transform = offsetLeft
    toVc.flag.transform = offsetLeft
    toVc.titleText.transform = offsetRight
    toVc.subtitleText.transform = offsetRight

    //5. get duration
    let duration = transitionDuration(transitionContext)


    //6. perform animation

    // fromView to toView will take place in half of the duration
    UIView.animateWithDuration(duration/2.0,
      animations: { () -> Void in
        fromView.transform = offsetLeft
        toView.transform = CGAffineTransformIdentity

        // to keep avatar and flag look like they stay at the same place
        // we transform them in a counter direction to their container view transform
        fromVc.avatar.transform = offsetRight
        fromVc.flag.transform = offsetRight
        toVc.avatar.transform = CGAffineTransformIdentity
        toVc.flag.transform = CGAffineTransformIdentity


    }) { (completed) -> Void in
    }

    // quickest animation of all, it takes one quarter of the whole duration to complete
    UIView.animateWithDuration(duration/4.0, animations: { () -> Void in
      fromVc.titleText.transform = offsetLeft
      toVc.titleText.transform = CGAffineTransformIdentity
    },completion: nil)

    // longest animation, at the end of this animation we'll call completeTransition to 
    // finalize the animation
    UIView.animateWithDuration(duration, animations: { () -> Void in
      fromVc.subtitleText.transform = offsetLeft
      toVc.subtitleText.transform = CGAffineTransformIdentity
    }) { (completed) -> Void in
      transitionContext.completeTransition(completed)
    }
  }
}


// MARK: UIViewControllerAnimatedTransitioning implementation
extension PushTransitionController : UIViewControllerTransitioningDelegate {
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
}












