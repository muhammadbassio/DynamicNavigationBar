//
//  Example
//
//  Copyright © 2018 Muhammad Bassio. All rights reserved.
//

import UIKit

open class DynamicNavigationBar: UIView {
  public var menuView: UIView?
  public var barView: UIView?
  public var overlayButton: UIButton?
  
  func updateState(percentage:CGFloat, radius:CGFloat) {
    let newAlpha = (percentage > 1) ? 1 : ((percentage < 0) ? 0 : percentage)
    self.overlayButton?.alpha = newAlpha
    self.menuView?.alpha = newAlpha
    self.barView?.alpha = 1 - newAlpha
    self.menuView?.clipsToBounds = true
    self.barView?.clipsToBounds = true
    self.clipsToBounds = true
    self.menuView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    self.barView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    self.menuView?.layer.cornerRadius = radius * percentage
    self.barView?.layer.cornerRadius = radius * percentage
    self.layer.cornerRadius = radius * percentage
  }
  
  func showMenu(radius:CGFloat) {
    UIView.animate(withDuration: 0.35) {
      self.overlayButton?.isUserInteractionEnabled = true
      self.overlayButton?.alpha = 1
      self.menuView?.alpha = 1
      self.barView?.alpha = 0
      self.menuView?.clipsToBounds = true
      self.barView?.clipsToBounds = true
      self.clipsToBounds = true
      self.menuView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      self.barView?.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
      self.menuView?.layer.cornerRadius = radius
      self.barView?.layer.cornerRadius = radius
      self.layer.cornerRadius = radius
    }
  }
  
  @objc func hideMenu() {
    UIView.animate(withDuration: 0.35) {
      self.overlayButton?.isUserInteractionEnabled = false
      self.overlayButton?.alpha = 0
      self.menuView?.alpha = 0
      self.barView?.alpha = 1
      self.menuView?.layer.cornerRadius = 0
      self.barView?.layer.cornerRadius = 0
      self.layer.cornerRadius = 0
    }
  }
  
  
}
