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
    tagView.dp_y = 200.0
    tagView.offset = 15

    self.view.isUserInteractionEnabled = true

    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    tap.numberOfTapsRequired = 1
    tap.numberOfTouchesRequired = 1
    self.view.addGestureRecognizer(tap)

    let longTap = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(rec:)))
    longTap.minimumPressDuration = 2
    self.view.addGestureRecognizer(longTap)
  }

  func handleLongPress(rec: UILongPressGestureRecognizer) {
    print("long")
    rec.isEnabled = false
    rec.removeTarget(self, action: #selector(handleLongPress(rec:)))

    var tags: [DPTag] = []

    let font: UIFont = .systemFont(ofSize: 12)
    for _ in 0 ..< 20 {
      tags.append(.init(tagType: .text, text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]), icon: nil, offset: 5, fixedSize: nil))
    }

    self.tagView.setTags(tags: tags)
  }

  func handleTap() {
    let font: UIFont = .systemFont(ofSize: 16)
    tagView.addTag(tag: .init(tagType: .text, text: .init(string: self.randomText, attributes: [NSForegroundColorAttributeName: UIColor.red, NSFontAttributeName: font]), icon: nil, offset: 5, fixedSize: nil))
  }

  var randomText: String {
    return ["下载", "WordPress", "到本地", "解压缩后将文件夹", "Git", "版本库", "Coding",  "项目", "的"].random()!
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
