//
//  Example
//
//  Copyright © 2018 Muhammad Bassio. All rights reserved.
//

import UIKit

class ViewController: ENBViewController {

  @IBOutlet var scrollView:UIScrollView?
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    return .portrait
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.scrollView?.contentSize = CGSize(width: 200, height: 1200)
  }

  @IBAction func closeMenu() {
    UIView.animate(withDuration: 0.35) {
      self.barHeightConstraint?.constant = self.navigationBarHeight
      self.view.layoutIfNeeded()
      self.navigationBar?.hideMenu()
      self.scrollView?.layer.cornerRadius = 0
      self.scrollView?.clipsToBounds = false
    }
  }

}

