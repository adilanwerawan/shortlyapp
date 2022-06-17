//
//  UIButton+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import UIKit

extension UIButton {
    /// If button is enabled then its background color would be UIColor.appGreen other wise its background color would be
    /// UIColor.nonValid
    var isValid: Bool {
        get { isEnabled && backgroundColor == .appGreen }
        set {
            backgroundColor = newValue ? .appGreen : .nonValid
            isEnabled = newValue
        }
    }
}
