//
//  ButtonBackgroungViewGreenBig.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import Foundation
import UIKit

final class ButtonBackgroungViewGreenBig:UIView, SingleChildViewConfiguration{
    
    lazy var backgroundView = UIView()
    
    init(){
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func addSubViews(){
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    internal func setupViews(){
        backgroundColor = .white
        backgroundView.backgroundColor = .white
        backgroundView.layer.backgroundColor = UIColor.appGreen?.cgColor
        backgroundView.standardCornerRadius()
    }
    
    func childView() -> UIView {
        return backgroundView
    }
}
