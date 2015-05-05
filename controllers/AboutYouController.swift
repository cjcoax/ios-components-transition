class AboutYouController: KeyboardViewController {

  // MARK: Properties

  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var bioTextView: UITextView!
  @IBOutlet weak var avatar: UIImageView!
  @IBOutlet weak var flag: UIImageView!
  @IBOutlet weak var titleText: UILabel!
  @IBOutlet weak var subtitleText: UILabel!


  // MARK: LiveCycles

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    bioTextView.becomeFirstResponder()
  }

  // MARK: Status bar

  override func prefersStatusBarHidden() -> Bool {
    return true
  }
}
