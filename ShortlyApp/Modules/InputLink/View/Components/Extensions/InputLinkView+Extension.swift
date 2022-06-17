//
//  InputLinkView+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import UIKit

extension InputLinkView{
    // Additional setup for the views
    func setupViews() {
        backgroundColor = .appBackground
        appTitleImage.contentMode = .scaleAspectFit
        splashImage.contentMode = .scaleAspectFit
        
        contentTitleLabel.text = "Let’s get started!"
        contentTitleLabel.font = .boldSystemFont(ofSize: 20)
        contentTitleLabel.textColor = .textColorDark
        
        contentDescriptionLabel.numberOfLines = 0
        contentDescriptionLabel.text = "Paste your first link into the field to shorten it"
        contentDescriptionLabel.textColor = .textColorDark
        contentDescriptionLabel.font = .systemFont(ofSize: 17)
        contentDescriptionLabel.textAlignment = .center
    }
    
    func startLoading() {
        self.bottomControlsView.inputURLTextField.isUserInteractionEnabled = false
        self.bottomControlsView.shortenLinkButton.isUserInteractionEnabled = false
        
        activityIndicationView.isHidden = false
        activityIndicationView.startAnimating()
    }
    
    func finishLoading() {
        self.bottomControlsView.inputURLTextField.isUserInteractionEnabled = true
        self.bottomControlsView.shortenLinkButton.isUserInteractionEnabled = true
        
        activityIndicationView.stopAnimating()
    }
}
