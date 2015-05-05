class ContactDetailsController: KeyboardViewController {

  // MARK: properties

  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var fullnameTextField: UITextField!
  @IBOutlet weak var avatar: UIImageView!
  @IBOutlet weak var flag: UIImageView!
  @IBOutlet weak var titleText: UILabel!
  @IBOutlet weak var subtitleText: UILabel!


  // MARK: LiveCycles

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    fullnameTextField.becomeFirstResponder()
  }

  @IBAction func didClickNext(sender: AnyObject) {
    self.stopListeningToKeyboardEvents()
    self.fullnameTextField.resignFirstResponder()
    self.performSegueWithIdentifier("to AboutYouController", sender: self)
  }

  // MARK: Status bar
  override func prefersStatusBarHidden() -> Bool {
    return true
  }


}
