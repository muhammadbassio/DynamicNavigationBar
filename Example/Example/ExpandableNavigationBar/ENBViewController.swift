//
//  Example
//
//  Copyright © 2018 Muhammad Bassio. All rights reserved.
//

import UIKit

class ENBViewController: UIViewController, UIScrollViewDelegate {
  
  @IBOutlet var barHeightConstraint: NSLayoutConstraint?
  @IBOutlet var navigationBar: ExpandableNavigationBar?
  @IBOutlet var menuView: UIView?
  @IBOutlet var navigationBarView: UIView?
  
  @IBInspectable var navigationBarHeight:CGFloat = 80
  
  var isDragging = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar?.barView = self.navigationBarView
    self.navigationBar?.menuView = self.menuView
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.isDragging = true
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.isDragging = false
    var round = false
    if #available(iOS 11.0, *) {
      if self.view.safeAreaInsets.bottom > 0 {
        round = true
      }
    }
    if scrollView.contentOffset.y < -150 {
      UIView.animate(withDuration: 0.35) {
        self.barHeightConstraint?.constant = self.navigationBarHeight + scrollView.bounds.height
        self.view.layoutIfNeeded()
        self.navigationBar?.showMenu(round: round)
        if round {
          scrollView.layer.cornerRadius = 30
          scrollView.clipsToBounds = true
        }
      }
    } else {
      UIView.animate(withDuration: 0.35) {
        self.barHeightConstraint?.constant = self.navigationBarHeight
        self.view.layoutIfNeeded()
        self.navigationBar?.hideMenu()
      }
    }
    
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if self.isDragging {
      let offset = scrollView.contentOffset.y
      if offset < 0 {
        let percentage = -offset / scrollView.bounds.height
        self.barHeightConstraint?.constant = self.navigationBarHeight - offset
        self.navigationBar?.updateState(percentage: percentage)
      }
    }
  }
  
}

