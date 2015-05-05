//
//  PushSegue.swift
//  ios-components
//
//  Created by Amir Rezvani on 4/20/15.
//  Copyright (c) 2015 Jogabo. All rights reserved.
//

import UIKit

//custom segue which perform animation
class PushTransitionSegue : UIStoryboardSegue {
  // MARK: properties
  let transitionController = PushTransitionController()



  // MARK: UIStoryboardSegue

  override func perform() {
    let sourceViewController = self.sourceViewController as! UIViewController
    let destinationViewController = self.destinationViewController as! UIViewController

    destinationViewController.transitioningDelegate = transitionController
    sourceViewController.presentViewController(destinationViewController, animated: true, completion: nil)
  }

}