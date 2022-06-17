//
//  ViewConfigurationProtocol.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import Foundation
import UIKit


/// Created this protocol so we can add views and setup autolayout constraints inside these functions implementations
protocol LeastViewConfiguration{
    /// Adding subviews  to the parent view
    func addSubViews()
    /// Setting up constraints for the subview
    func setupConstraints()
}

/// After adding subviews and configuring constraints do addtional UI work
protocol ViewConfiguration:LeastViewConfiguration{
    /// Addtional UI presentational setup like backgroundColor, font etc
    func setupViews()
}

// MARK: Seperately created protocol(interface) for the view which will have only one child
protocol SingleChildViewConfiguration:ViewConfiguration{
    func childView() -> UIView
}

extension SingleChildViewConfiguration where Self:UIView{
    // MARK: Created protocol extension for the SingleChildViewConfiguration and added the default implementation for setting up the constraints for single child view
    func setupConstraints() {
        NSLayoutConstraint.activate([
            childView().centerXAnchor.constraint(equalTo: self.centerXAnchor),
            childView().centerYAnchor.constraint(equalTo: self.centerYAnchor),
            childView().widthAnchor.constraint(equalTo: self.widthAnchor),
            childView().heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
}
