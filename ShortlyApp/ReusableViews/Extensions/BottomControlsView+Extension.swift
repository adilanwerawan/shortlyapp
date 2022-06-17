//
//  BottomControlsView+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import UIKit

// MARK: Created extension to add more functions
// Used extensions for better code readability and maintenance
extension BottomControlsView{
    func setupViews() {
        backgroundColor = .appBottomViewColor
        
        shortenLinkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        shortenLinkButton.setTitle("SHORTEN IT!", for: .normal)
        
        inputURLTextField.placeholder = "Shorten a link here..."
        
        buttonBackgroundView.standardCornerRadius()
        textFieldBackgroundView.standardCornerRadius()
    }
}
