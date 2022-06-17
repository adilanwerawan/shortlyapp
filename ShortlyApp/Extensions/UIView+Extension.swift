//
//  UIView+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import UIKit

extension UIView{
    func standardCornerRadius(value:Double = 4.0){
        /*
         Setting the corner radius to the view and defined here in extension so it can be used and
         changed through out the app easily
         */
        self.layer.cornerRadius = value
    }
}
