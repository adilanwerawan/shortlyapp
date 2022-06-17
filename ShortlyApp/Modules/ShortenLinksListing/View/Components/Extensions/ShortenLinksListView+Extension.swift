//
//  InputListView+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation
import UIKit

extension ShortenLinksListView{
    func setupViews() {
        backgroundColor = .appBackground
        linksCollectionView.backgroundColor = .appBackground
    }
    
    func collectionLayout() -> UICollectionViewLayout{
        let heightPercent = 176.0/screenHeight
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(.calculateHeight(heightPercent: heightPercent)))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        section.interGroupSpacing = 5
        
        return UICollectionViewCompositionalLayout(section: section)
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
