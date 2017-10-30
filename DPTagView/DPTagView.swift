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
//  元素边距
  var offset: CGFloat = 5.0
  private var tags: [DPTag] = []

  override func layoutSubviews() {
    super.layoutSubviews()

    for btn in self.subviews {
      btn.removeFromSuperview()
    }

    var curX: CGFloat = self.offset
    var curY: CGFloat = self.offset
    var curLineMaxHeight: CGFloat = 0.0

    for tag in self.tags {
      let btn = UIButton(type: .custom)
      self.addSubview(btn)
      btn.setAttributedTitle(tag.text, for: .normal)
//      计算按钮的大小
      let tagSize = tag.sizeOfText
      btn.size = tagSize
      print(tag)
      btn.dp_width += tag.offset * 2
      btn.dp_x = curX
      btn.dp_y = curY

      curX += btn.dp_width + self.offset

//      TODO 不等高情况下处理
//      获取当前行最大高度
      if btn.dp_height > curLineMaxHeight {
        curLineMaxHeight = btn.dp_height
      }

//      如果当前位置无法承载元素，另起一行，以当前行元素最大高度为换行标准
      if self.dp_width - curX < 0 {
        curY += curLineMaxHeight + self.offset
        curX = self.offset

        btn.dp_x = curX
        btn.dp_y = curY

        curX += btn.dp_width + self.offset
      }

      btn.backgroundColor = .random()
    }

    self.dp_height = curY + curLineMaxHeight + self.offset
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

struct DPTag: CustomStringConvertible {
  var tagType: DPTagType = .text
  var text: NSAttributedString?
  var icon: UIImage?

//  左右边距
  var offset: CGFloat = 10.0

  var sizeOfText: CGSize {
    if let t = text {
      return t.boundingRect(with: CGSize(width: 100000, height: 1000), context: nil).size
    }
    return .zero
  }

  var sizeOfIcon: CGSize {
    if let img = icon {
      return img.size
    }
    return .zero
  }

  var description: String {
    return "tagName: \(self.text!.string) size: \(self.sizeOfText)"
  }


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
