// UIViewControllerTransitioningDelegate Example

import UIKit
import QuartzCore

// Custom Segue class to perform custom animations

class TransitionSegue: UIStoryboardSegue {

  // MARK: properties
  let transitionManager = TransitionManager()
  let completion: (() -> Void)?

  init(source: UIViewController, destination: UIViewController, completion: (() -> Void)? = nil) {
    self.completion = completion
    super.init(identifier: "TransitionSegue", source: source, destination: destination)
  }

  // MARK: UIStoryboardSegue
  
  override func perform() {
    let sourceViewController = self.sourceViewController as! UIViewController
    let destinationViewController = self.destinationViewController as! UIViewController

    destinationViewController.transitioningDelegate = transitionManager
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: completion)
  }
}

// TransitionManager handle screens transitions

class TransitionManager: NSObject {
}

// MARK: TransitionManager + UIViewControllerTransitioningDelegate

extension TransitionManager: UIViewControllerTransitioningDelegate {

  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }

  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
}

// MARK: TransitionManager + UIViewControllerAnimatedTransitioning

extension TransitionManager: UIViewControllerAnimatedTransitioning {

  // This is used for percent driven interactive transitions,
  // as well as for container controllers that have companion animations that might need to
  // synchronize with the main animation.
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 0.5
  }

  // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {

    // get reference to our fromView, toView and the container view that we should perform the transition in
    let container = transitionContext.containerView()
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!

    // set up from 2D transforms that we'll use in the animation
    let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
    let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)

    // start the toView to the right of the screen
    toView.transform = offScreenRight

    // add the both views to our view controller
    container.addSubview(toView)
    container.addSubview(fromView)

    // get the duration of the animation
    let duration = self.transitionDuration(transitionContext)

    // perform the animation!
    UIView.animateWithDuration(duration, delay: 0.0, options: nil, animations: {
      fromView.transform = offScreenLeft
      toView.transform = CGAffineTransformIdentity
      }, completion: { finished in

        // tell our transitionContext object that we've finished animating
        transitionContext.completeTransition(true)
    })
  }

  // This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
  func animationEnded(transitionCompleted: Bool) {
  }
}