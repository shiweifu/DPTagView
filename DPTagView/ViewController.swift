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
    tagView.dp_height = 200.0
    self.view.addSubview(tagView)
    tagView.backgroundColor = .yellow
    tagView.dp_x = 0.0
    tagView.dp_y = 200.0
    let attrStr = NSAttributedString(string: "hello",
                                 attributes: [NSForegroundColorAttributeName: UIColor.red])
    let t = DPTag(tagType: .text, text: attrStr, icon: nil, offset: 5)
    tagView.addTag(tag: t)
  }

}
