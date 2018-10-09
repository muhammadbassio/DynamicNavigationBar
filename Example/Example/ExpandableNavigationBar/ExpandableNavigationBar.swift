//
//  Example
//
//  Copyright © 2018 Muhammad Bassio. All rights reserved.
//

import UIKit

class ExpandableNavigationBar: UIView {
  var menuView: UIView?
  var barView: UIView?
  
  func updateState(percentage:CGFloat) {
    let newAlpha = (percentage > 1) ? 1 : ((percentage < 0) ? 0 : percentage)
    self.menuView?.alpha = newAlpha
    self.barView?.alpha = 1 - newAlpha
  }
  
  func showMenu(round:Bool) {
    UIView.animate(withDuration: 0.35) {
      self.menuView?.alpha = 1
      self.barView?.alpha = 0
      if round {
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
      }
    }
  }
  
  func hideMenu() {
    UIView.animate(withDuration: 0.35) {
      self.menuView?.alpha = 0
      self.barView?.alpha = 1
      self.layer.cornerRadius = 0
    }
  }
  
  
}
