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
  case normal // 文本类型
  case ellipse // 不规则气泡
}

class DPTagView: UIView {

  var lineSpace: CGFloat = 10.0  // 行间距
//  元素边距
  var offset: CGFloat = 5.0 {
    didSet {
      self.reset()
    }
  }
  private var tags: [DPTag] = []

  private var curPosX: CGFloat = 0.0
  private var curPosY: CGFloat = 0.0
  var curLineMaxHeight: CGFloat = 0.0

  func addTag(tag: DPTag) {
    self.tags.append(tag)
    renderElement(newTag: tag, index: self.tags.count - 1)
  }

  func setTags(tags: [DPTag]) {
    self.tags = tags
    rebuild()
  }

  func rebuild() {
    for btn in self.subviews {
      btn.removeFromSuperview()
    }

    reset()

//    根据元素逐个添加
    for (index, tag) in self.tags.enumerated() {
      renderElement(newTag: tag, index: index)
    }

  }

  private func renderElement(newTag: DPTag, index: Int) {
    let tag = newTag

    var curX: CGFloat = self.curPosX
    var curY: CGFloat = self.curPosY

//    最终tag元素的坐标
    var tagBtnX: CGFloat = 0
    var tagBtnY: CGFloat = 0

    var tagElementView: UIView!

//    自定义视图或者文本视图
    if let createBlock = tag.customViewBlock {
      tagElementView = createBlock(tag)
    }
    else {
      let btn = UIButton(type: .custom)
      btn.setAttributedTitle(tag.text, for: .normal)
      let tagSize = tag.sizeOfText
      btn.dp_size = tagSize
      tagElementView = btn
    }

    tagElementView.tag = index
    self.addSubview(tagElementView)

    tagBtnX = curX
    tagBtnY = curY

//    计算下一个元素的横轴坐标
    curX += tagElementView.dp_width + self.offset

    var wrapLineFlag = false
//      如果当前位置无法承载元素，另起一行，以当前行元素最大高度为换行标准
    if self.dp_width - curX < 0 {
      curY += curLineMaxHeight + self.offset
      curX = self.offset

//      换行之后，当前行最大高度

      tagBtnX = curX
      tagBtnY = curY

      curX += tagElementView.dp_width + self.offset // 获得下一个元素应该所在的位置
      wrapLineFlag = true
    }

//      获取当前行最大高度
    if tagElementView.dp_height > curLineMaxHeight {
      curLineMaxHeight = tagElementView.dp_height
    }

    tagElementView.backgroundColor = tag.backgroundColor
//    添加事件
    let tapGesture = UITapGestureRecognizer()
    tagElementView.addGestureRecognizer(tapGesture)
    tapGesture.addTarget(self, action: #selector(handleTagTouch(gesture:)))

    self.curPosX = curX
    self.curPosY = curY

    if wrapLineFlag {
      curLineMaxHeight = tagElementView.dp_height
    }

//    更改当前视图的高度
    self.dp_height = curY + curLineMaxHeight + self.offset

    UIView.animate(withDuration: 0.25) {
      tagElementView.dp_x = tagBtnX
      tagElementView.dp_y = tagBtnY
    }
  }

  func removeAllTags() {
    for tagView in self.subviews {
      UIView.animate(withDuration: 0.5, animations: {
        tagView.dp_x = 0
        tagView.dp_y = 0
      }, completion: { b in
        tagView.removeFromSuperview()
      })
    }

    self.tags = []
    self.reset()
  }

  func removeTag(tag: DPTag) {
    if let idx = self.tags.index(of: tag) {
      tags.remove(at: idx)
      rebuild()
    }
  }

  func handleTagTouch(gesture: UITapGestureRecognizer) {
    if let tapView = gesture.view {
      let tagIdx = tapView.tag
      let tag = self.tags[tagIdx]
      if let tapAction = tag.tapActionBlock {
        tapAction(tag)
      }
    }
  }

  func reset() {
    self.curPosX = self.offset
    self.curPosY = self.offset
    self.curLineMaxHeight = 0.0
  }

}

class DPTag: NSObject {
  var tagType: DPTagType = .text
  var text: NSAttributedString?
  var icon: UIImage?
  var backgroundColor: UIColor?
//  左右边距
  var offset: CGFloat = 10.0
//   用户可配置固定的元素大小
  var fixedSize: CGSize? = nil

  var customViewBlock: ((DPTag) -> UIView)!
  var tapActionBlock: ((DPTag) -> Void)? = nil

  var ext: Any? = nil

  var sizeOfText: CGSize {

    if let size = self.fixedSize {
      return size
    }

    if let t = text {
      let result = t.boundingRect(with: CGSize(width: 100000, height: 1000), context: nil).size
      return CGSize(width: result.width + self.offset * 2, height: result.height + self.offset * 2)
    }
    return .zero
  }

  override var description: String {
    return "tagName: \(self.text!.string) size: \(self.sizeOfText)"
  }

  init( tagType: DPTagType = .text,
           text: NSAttributedString?,
           icon: UIImage? = nil,
backgroundColor: UIColor? = nil,
         offset: CGFloat = 10.0,
      fixedSize: CGSize? = nil,
            ext: Any? = nil,  // 任意参数
customViewBlock: ((DPTag) -> UIView)! = nil,
 tapActionBlock: ((DPTag) -> Void)? = nil) {
    super.init()
    self.tagType = tagType
    self.text = text
    self.icon = icon
    self.backgroundColor = backgroundColor
    self.offset = offset
    self.fixedSize = fixedSize
    self.ext = ext
    self.customViewBlock = customViewBlock
    self.tapActionBlock = tapActionBlock
  }

  deinit {
    print("\(self.text?.string) has been deinit")
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

  public var dp_centerX: CGFloat {
    get {
      return self.center.x
    } set(value) {
      self.center.x = value
    }
  }

  public var dp_centerY: CGFloat {
    get {
      return self.center.y
    } set(value) {
      self.center.y = value
    }
  }

  public var dp_size: CGSize {
    get {
      return self.frame.size
    } set(value) {
      self.frame = CGRect(origin: self.frame.origin, size: value)
    }
  }

}
