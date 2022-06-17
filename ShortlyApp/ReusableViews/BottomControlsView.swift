//
//  BottomControlsView.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import UIKit

final class BottomControlsView: UIView, ViewConfiguration {

    // MARK: Subviews
    lazy var textFieldBackgroundView = TextFieldBackgroundView()
    lazy var buttonBackgroundView = ButtonBackgroungViewGreenBig()
    lazy var imageCircle = UIImageView(image: UIImage(named: "shape"))
    // MARK: Text field to take input from user for link to be shorten
    lazy var inputURLTextField = UITextField()
    // MARK: On press of thing button api would be called for shortening the link
    lazy var shortenLinkButton = UIButton(type: .custom)
    
    init(){
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews() {
        [imageCircle,textFieldBackgroundView, buttonBackgroundView].forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        textFieldBackgroundView.backgroundView.addSubview(inputURLTextField)
        buttonBackgroundView.backgroundView.addSubview(shortenLinkButton)
        inputURLTextField.translatesAutoresizingMaskIntoConstraints = false
        shortenLinkButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        let heightPercent = 50.0/screenHeight
        
        NSLayoutConstraint.activate([
            
            imageCircle.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            imageCircle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30),
            imageCircle.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.70),
            imageCircle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.70),
            
            textFieldBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 46.0),
            textFieldBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            textFieldBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            textFieldBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            textFieldBackgroundView.heightAnchor.constraint(equalToConstant: screenHeight * heightPercent),
            
            inputURLTextField.centerXAnchor.constraint(equalTo: textFieldBackgroundView.centerXAnchor),
            inputURLTextField.centerYAnchor.constraint(equalTo: textFieldBackgroundView.centerYAnchor),
            inputURLTextField.heightAnchor.constraint(equalTo: textFieldBackgroundView.heightAnchor),
            inputURLTextField.widthAnchor.constraint(equalTo: textFieldBackgroundView.widthAnchor, constant: -20),
            
            buttonBackgroundView.topAnchor.constraint(equalTo: textFieldBackgroundView.bottomAnchor, constant: 10),
            buttonBackgroundView.leadingAnchor.constraint(equalTo: textFieldBackgroundView.leadingAnchor),
            buttonBackgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonBackgroundView.trailingAnchor.constraint(equalTo: textFieldBackgroundView.trailingAnchor),
            buttonBackgroundView.heightAnchor.constraint(equalToConstant: screenHeight * heightPercent),
            
            shortenLinkButton.centerXAnchor.constraint(equalTo: buttonBackgroundView.centerXAnchor),
            shortenLinkButton.centerYAnchor.constraint(equalTo: buttonBackgroundView.centerYAnchor),
            shortenLinkButton.heightAnchor.constraint(equalTo: buttonBackgroundView.heightAnchor),
            shortenLinkButton.widthAnchor.constraint(equalTo: buttonBackgroundView.widthAnchor)
        
        ])
    }
}
