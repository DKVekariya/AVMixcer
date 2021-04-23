//
//  UIViewController+Extention.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 23/04/21.
//

import UIKit



@nonobjc extension UIViewController {
    func insert(_ child: UIViewController, in container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.pinToAllEdeges(to: container)
        child.didMove(toParent: self)
    }
}
