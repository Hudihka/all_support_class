

import UIKit

class ContainerScrollView: UIScrollView {
  var scrollView: UIScrollView?

  func setScrollView(_ scrollView: UIScrollView) {
    self.scrollView = scrollView
    addSubview(scrollView)
  }
}
