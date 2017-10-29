//
// Created by shiweifu on 10/29/17.
// Copyright (c) 2017 dollop.us. All rights reserved.
//

import Foundation
import UIKit

enum DPTagType {
  case text
  case icon
  case iconText
}

enum DPTagViewShowType {
  case normal // 文本举行
  case ellipse // 不规则气泡
}

class DPTagView: UIView {

  var lineSpace: CGFloat = 10.0  // 行间距
  private var tags: [DPTag] = []

  override func layoutSubviews() {
    super.layoutSubviews()

    for btn in self.subviews {
      btn.removeFromSuperview()
    }

    for tag in self.tags {
      let btn = UIButton(type: .custom)
      self.addSubview(btn)
      btn.setAttributedTitle(tag.text, for: .normal)
      btn.sizeToFit()
      btn.dp_x = 0
      btn.dp_y = 0
    }

  }

  func addTag(tag: DPTag) {
    self.tags.append(tag)
    rebuild()
  }

  func setTags(tags: [DPTag]) {
    self.tags = tags
    rebuild()
  }

  func rebuild() {
    self.setNeedsLayout()
  }

}

struct DPTag {
  var tagType: DPTagType = .text
  var text: NSAttributedString?
  var icon: UIImage?


//  边距
  var offset: CGFloat = 5.0
}

extension UIView {

  public var dp_x: CGFloat {
    get {
      return self.frame.origin.x
    } set(value) {
      self.frame = CGRect(x: value, y: self.dp_y, width: self.dp_width, height: self.dp_height)
    }
  }

  public var dp_y: CGFloat {
    get {
      return self.frame.origin.y
    } set(value) {
      self.frame = CGRect(x: self.dp_x, y: value, width: self.dp_width, height: self.dp_height)
    }
  }

  public var dp_width: CGFloat {
    get {
      return self.frame.size.width
    } set(value) {
      self.frame = CGRect(x: self.dp_x, y: self.dp_y, width: value, height: self.dp_height)
    }
  }

  public var dp_height: CGFloat {
    get {
      return self.frame.size.height
    } set(value) {
      self.frame = CGRect(x: self.dp_x, y: self.dp_y, width: self.dp_width, height: value)
    }
  }

  public var origin: CGPoint {
    get {
      return self.frame.origin
    } set(value) {
      self.frame = CGRect(origin: value, size: self.frame.size)
    }
  }

  public var centerX: CGFloat {
    get {
      return self.center.x
    } set(value) {
      self.center.x = value
    }
  }

  public var centerY: CGFloat {
    get {
      return self.center.y
    } set(value) {
      self.center.y = value
    }
  }

  public var size: CGSize {
    get {
      return self.frame.size
    } set(value) {
      self.frame = CGRect(origin: self.frame.origin, size: value)
    }
  }

}
