// source https://github.com/chrisgummer/keyboard-view/blob/master/KeyboardView/ViewController.swift

import UIKit

/// KeyboardViewController
/// Let you create a view controller with a bottomLayoutConstraint that stick to the keyboard

class KeyboardViewController: UIViewController {

  @IBOutlet weak var bottomLayoutConstraint: NSLayoutConstraint!

  // MARK: Life cycle

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    listenToKeyboardEvents()
  }

  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    stopListeningToKeyboardEvents()
  }

  // MARK: Notifications

  func keyboardWillShow(notification: NSNotification) {
    updateBottomLayoutConstraintWithNotification(notification)
  }

  func keyboardWillHide(notification: NSNotification) {
    updateBottomLayoutConstraintWithNotification(notification)
  }

  func listenToKeyboardEvents() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
  }

  func stopListeningToKeyboardEvents() {
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
  }

  // MARK: Private

  func updateBottomLayoutConstraintWithNotification(notification: NSNotification) {
    let userInfo = notification.userInfo!

    let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
    let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
    let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
    let rawAnimationCurve = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntValue << 16
    let animationCurve = UIViewAnimationOptions.init(UInt(rawAnimationCurve))

    bottomLayoutConstraint.constant = CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame)

    UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | animationCurve, animations: {
      self.view.layoutIfNeeded()
      }, completion: nil)
  }

}

