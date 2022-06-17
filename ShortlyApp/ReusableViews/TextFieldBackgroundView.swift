//
//  TextFieldBackgroundView.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import Foundation
import UIKit

/// Created general TextFieldBackgroundView to resue inside the app
final class TextFieldBackgroundView:UIView, SingleChildViewConfiguration{
   
    // MARK: Subview
    lazy var backgroundView = UIView()
    
    init(){
        super.init(frame: .zero)
        addSubViews()
        /// Called default implementation for setting up the constraints
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Adding subview in this view
    internal func addSubViews(){
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    /// Setup other necessary things
    internal func setupViews(){
        backgroundColor = .white
        backgroundView.backgroundColor = .white
        backgroundView.standardCornerRadius()
    }
    /// Returning child view for the defullt implementation of func setupConstraints() inside SingleChildViewConfiguration's protocol extension
    func childView() -> UIView {
        return backgroundView
    }
}
