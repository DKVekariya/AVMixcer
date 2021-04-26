//
//  UIView+Extension.swift
//  AVMixcer
//
//  Created by Divyesh Vekariya on 26/04/21.
//

import Foundation
import UIKit
extension UIView {
    
    func pinToAllEdeges(to: UIView)  {
        self.leadingAnchor.constraint(equalTo: to.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: to.trailingAnchor).isActive = true
        self.topAnchor.constraint(equalTo: to.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor).isActive = true
    }
    
}
