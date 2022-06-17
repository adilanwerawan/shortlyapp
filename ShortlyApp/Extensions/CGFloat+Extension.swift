//
//  CGFloat+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import UIKit

extension CGFloat{
    /// Calculating the height according to the given percentage, by mutiplying this percentage to the UIScreen bound's height
    static func calculateHeight(heightPercent:Double) -> CGFloat{
        CGFloat(screenHeight * heightPercent)
    }
    /// Calculating the width according to the given percentage, by mutiplying this percentage to the UIScreen bound's width
    static func calculateWidth(widthPercent:Double) -> CGFloat{
        CGFloat(screenWidth * widthPercent)
    }
}
