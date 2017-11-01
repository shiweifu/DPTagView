//
//  ViewController.swift
//  DPTagView
//
//  Created by shiweifu on 10/29/17.
//  Copyright (c) 2017 dollop.us. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

  var tagView: DPTagView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tagView = DPTagView(frame: .zero)
    tagView.dp_width  = self.view.dp_width
    tagView.dp_height = 100.0
    self.view.addSubview(tagView)
    tagView.backgroundColor = .yellow
    tagView.dp_x = 0.0
    tagView.dp_y = 0.0
    tagView.offset = 15

    var tagSize = CGSize(width: 105, height: 26)
    let font: UIFont = .systemFont(ofSize: 14)

    let tapAction:((DPTag) -> Void) = { (tag) in
      print("you tap \(tag.text?.string)")
      self.tagView.removeTag(tag: tag)
    }

    tagView.addTag(tag: .init(text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]), backgroundColor: UIColor.random(), fixedSize: tagSize))
    tagView.addTag(tag: .init(text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]), backgroundColor: UIColor.random(), fixedSize: tagSize))
    tagSize = .init(width: 100, height: 100)
    tagView.addTag(tag: .init(text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]), backgroundColor: UIColor.random(), fixedSize: tagSize))

    let createCustomViewAction:((DPTag) -> UIView) = { tag in
      let tagView: DPIconTagView = .fromNib()
      tagView.dp_width  = 100.0
      tagView.dp_height = 130.0
      tagView.iconImageView.image = tag.icon
      tagView.label.text = "hello world"
      return tagView
    }

    let tag = DPTag.init(text: .init(string: self.randomText,
                   attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]),
                            icon: UIImage(named: "icon"),
                 backgroundColor: UIColor.random(),
                          offset: 15, fixedSize: nil,
                 customViewBlock: createCustomViewAction,
                  tapActionBlock: tapAction);
    tagView.addTag(tag: tag)
  }

  var randomText: String {
    return ["下载", "WordPress", "到本地", "解压缩后将文件夹", "Git", "版本库", "Coding",  "项目", "的"].random()!
  }
  
  @IBAction func handleAddTags(_ sender: Any) {
    var tags: [DPTag] = []

    let font: UIFont = .systemFont(ofSize: 12)
    for _ in 0 ..< 20 {
      tags.append(.init(tagType: .text,
                           text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]),
                           icon: nil,
                backgroundColor: UIColor.random(),
                         offset: 5,
                      fixedSize: nil,
                customViewBlock: nil))
    }

    self.tagView.setTags(tags: tags)
  }

  @IBAction func handleClearTags(_ sender: Any) {
    self.tagView.removeAllTags()
  }
  
  @IBAction func handleAddTag(_ sender: Any) {
    let font: UIFont = .systemFont(ofSize: 16)
    tagView.addTag(tag: .init(tagType: .text, text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]), icon: nil, backgroundColor: UIColor.random(), offset: 5, fixedSize: nil, customViewBlock: nil))
  }
  
  @IBAction func handleAddCustomView(_ sender: Any) {

    let tapAction:((DPTag) -> Void) = { (tag) in
      print("you tap \(tag.text?.string)")
      self.tagView.removeTag(tag: tag)
    }

    let createCustomViewAction:((DPTag) -> UIView) = { tag in
      let tagView: DPIconTagView = .fromNib()
      tagView.dp_width  = 100.0
      tagView.dp_height = 130.0
      tagView.iconImageView.image = tag.icon
      tagView.label.text = "hello world"
      return tagView
    }

    let tag = DPTag.init(text: .init(string: self.randomText, attributes: nil),
            icon: UIImage(named: "icon"),
            backgroundColor: UIColor.random(),
            offset: 15, fixedSize: nil,
            customViewBlock: createCustomViewAction,
            tapActionBlock: tapAction);
    tagView.addTag(tag: tag)
  }

}

extension UIColor {
  class func random() -> UIColor {
    return [UIColor.green,
            UIColor.gray,
            UIColor.orange,
            UIColor.blue,
            UIColor.purple,
            UIColor.red].random()!
  }
}

extension Array {

  public func random() -> Element? {
    guard count > 0 else { return nil }
    let index = Int(arc4random_uniform(UInt32(self.count)))
    return self[index]
  }

}
