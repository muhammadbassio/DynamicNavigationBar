//
//  Example
//
//  Copyright © 2018 Muhammad Bassio. All rights reserved.
//

import UIKit

class DynamicViewController: UIViewController, UIScrollViewDelegate {
  
  static var ScrollThreshold:CGFloat = 100
  
  @IBOutlet var barHeightConstraint: NSLayoutConstraint?
  @IBOutlet var viewTopConstraint: NSLayoutConstraint?
  @IBOutlet var navigationBar: DynamicNavigationBar?
  @IBOutlet var menuView: UIView?
  @IBOutlet var navigationBarView: UIView?
  @IBOutlet var overlayButton: UIButton?
  
  @IBInspectable var navigationBarMinHeight:CGFloat = 44 {
    didSet {
      if self.navigationBarMinHeight > self.navigationBarMaxHeight {
        self.navigationBarMaxHeight = self.navigationBarMinHeight
      }
      if let const = self.barHeightConstraint?.constant {
        if self.navigationBarMinHeight > const {
          self.barHeightConstraint?.constant = self.navigationBarMinHeight
        }
      }
    }
  }
  
  @IBInspectable var navigationBarMaxHeight:CGFloat = 80 {
    didSet {
      if self.navigationBarMinHeight > self.navigationBarMaxHeight {
        self.navigationBarMinHeight = self.navigationBarMaxHeight
      }
      if let const = self.barHeightConstraint?.constant {
        if self.navigationBarMaxHeight < const {
          self.barHeightConstraint?.constant = self.navigationBarMaxHeight
        }
      }
    }
  }
  
  @IBInspectable var menuCornerRadius: CGFloat = 15
  
  @IBInspectable var navigationBarExtensionHeight:CGFloat = 60 {
    didSet {
      if self.navigationBarExtensionHeight != 0 {
        if self.navigationBarExtensionHeight > 0 {
          if self.navigationBarExtensionHeight < self.navigationBarMaxHeight {
            self.navigationBarExtensionHeight = self.navigationBarMaxHeight
          }
        } else {
          self.navigationBarExtensionHeight = 0
        }
      }
    }
  }
  
  
  var isDragging = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar?.barView = self.navigationBarView
    self.navigationBar?.menuView = self.menuView
    self.navigationBar?.overlayButton = self.overlayButton
    self.barHeightConstraint?.constant = self.navigationBarMaxHeight
    self.viewTopConstraint?.constant = self.navigationBarMaxHeight
    self.navigationBar?.hideMenu()
  }
  
  @IBAction func closeMenu() {
    UIView.animate(withDuration: 0.35) {
      self.barHeightConstraint?.constant = self.navigationBarMaxHeight
      self.view.layoutIfNeeded()
      self.navigationBar?.hideMenu()
    }
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.isDragging = true
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.isDragging = false
    let offset = scrollView.contentOffset.y
    
    if offset < 0 {
      UIView.animate(withDuration: 0.35) {
        if offset < -DynamicViewController.ScrollThreshold {
          let extraHeight = (self.navigationBarExtensionHeight > 0) ? self.navigationBarExtensionHeight : scrollView.bounds.height
          self.barHeightConstraint?.constant = self.navigationBarMaxHeight + extraHeight
          self.navigationBar?.showMenu(radius: self.menuCornerRadius)
        } else {
          self.barHeightConstraint?.constant = self.navigationBarMaxHeight
          self.viewTopConstraint?.constant = self.navigationBarMaxHeight
          self.navigationBar?.hideMenu()
        }
        self.view.layoutIfNeeded()
      }
    } else {
      let diff = self.navigationBarMaxHeight - self.navigationBarMinHeight
      UIView.animate(withDuration: 0.35) {
        if offset < diff {
          self.barHeightConstraint?.constant = self.navigationBarMaxHeight - offset
          self.viewTopConstraint?.constant = self.navigationBarMaxHeight - offset
        } else {
          self.barHeightConstraint?.constant = diff
          self.viewTopConstraint?.constant = diff
        }
        self.view.layoutIfNeeded()
        self.navigationBar?.hideMenu()
      }
    }
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset.y
    if offset <= 0 {
      if self.isDragging {
        let maxHeight = (self.navigationBarExtensionHeight > 0) ? max(self.navigationBarExtensionHeight, DynamicViewController.ScrollThreshold) : scrollView.bounds.height
        let percentage = -offset / maxHeight
        self.barHeightConstraint?.constant = self.navigationBarMaxHeight - offset
        self.navigationBar?.updateState(percentage: percentage, radius: self.menuCornerRadius)
      }
    } else {
      self.navigationBar?.updateState(percentage: 0, radius: self.menuCornerRadius)
      let diff = self.navigationBarMaxHeight - self.navigationBarMinHeight
      if offset < diff {
        self.barHeightConstraint?.constant = self.navigationBarMaxHeight - offset
        self.viewTopConstraint?.constant = self.navigationBarMaxHeight - offset
      } else {
        self.barHeightConstraint?.constant = diff
        self.viewTopConstraint?.constant = diff
      }
    }
  }
  
}

