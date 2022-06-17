//
//  String+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import UIKit

extension String{
    /// Validation of input url
    func validateUrl () -> Bool {
        guard let url = URL(string: self) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
}
