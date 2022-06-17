//
//  InputLinkView.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import UIKit

// MARK: InputLinkView has been implemented
/// Purpose: Containing the sub views related to InputLinkViewController like TextField, Shorten it button etc

final class InputLinkView: UIView, ViewConfiguration {
    
    // MARK: Subviews
    // Adding the text field background
    lazy var appTitleImage = UIImageView(image: UIImage(named: "logo"))
    lazy var splashImage = UIImageView(image: UIImage(named: "illustration"))
    lazy var bottomControlsView = BottomControlsView()
    lazy var contentTitleLabel = UILabel()
    lazy var contentDescriptionLabel = UILabel()
    internal lazy var activityIndicationView = ActivityIndicatorView(style: .medium)
    
    init(){
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Adding subview like textFieldBackround to this view
    func addSubViews() {
        let subviews = [appTitleImage,splashImage, bottomControlsView, contentTitleLabel, contentDescriptionLabel, activityIndicationView]
        subviews.forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    // Setting Autolayout constraints to subviews
    func setupConstraints() {
        
        let defaultMarginTop = 20.0
        let topMarginSplashImage = 15.0
        let heightPercentAppTitleLabel = 32.0/screenHeight
        let widthPercentAppTitleLabel = 120.0/screenWidth
        let bottomControlsViewHeightPercent = 204.0/screenHeight
        let splashImageHeightPercent = 324.0/screenHeight
        
        let bottomViewTopConstraint = bottomControlsView.topAnchor.constraint(equalTo: contentDescriptionLabel.bottomAnchor, constant: 10)
        bottomViewTopConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            appTitleImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: defaultMarginTop),
            appTitleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            appTitleImage.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: heightPercentAppTitleLabel)),
            appTitleImage.widthAnchor.constraint(equalToConstant: .calculateWidth(widthPercent: widthPercentAppTitleLabel)),
            
            splashImage.topAnchor.constraint(equalTo: appTitleImage.bottomAnchor, constant: topMarginSplashImage),
            splashImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            splashImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            splashImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            splashImage.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: splashImageHeightPercent)),
            
            contentTitleLabel.topAnchor.constraint(equalTo: splashImage.bottomAnchor, constant: 5),
            contentTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            contentDescriptionLabel.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 10),
            contentDescriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80),
            contentDescriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentDescriptionLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -80),
            
            bottomViewTopConstraint,
            bottomControlsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
            bottomControlsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomControlsView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomControlsView.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: bottomControlsViewHeightPercent)),
            
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
        
        /// For old iphones like iPhone 8 and olders
        /// If device do not have notch then did addtional adjustment
        func additionalUIHandling(){
            let splashImageNonNotchHeightPercent = 194.0/screenHeight
            splashImage.heightAnchor.constraint(equalToConstant: .calculateHeight(heightPercent: splashImageNonNotchHeightPercent)).isActive = true
            contentDescriptionLabel.font = .systemFont(ofSize: 11.0)
        }
        
        if !UIDevice().hasNotch{
            additionalUIHandling()
        }
    }
}

extension UIDevice {
    var hasNotch: Bool {
       let keywindow = UIApplication.shared.windows.first { $0.isKeyWindow }
       let bottom = keywindow?.safeAreaInsets.bottom ?? 0
       return bottom > 0
    }
}
