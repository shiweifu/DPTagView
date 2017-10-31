//
//  DPIconTagView.swift
//  DPTagView
//
//  Created by shiweifu on 10/31/17.
//  Copyright © 2017 dollop.us. All rights reserved.
//

import UIKit

class DPIconTagView: UIView {
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var label: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    self.translatesAutoresizingMaskIntoConstraints = false
    self.autoresizingMask = .init()
  }

}

// code from https://stackoverflow.com/questions/24857986/load-a-uiview-from-nib-in-swift
extension UIView {
  class func fromNib<T: UIView>() -> T {
    return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
  }
}
