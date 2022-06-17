//
//  InputListView.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import UIKit

// MARK: ShortenLinksListView has been implemented
/// Purpose: Contains the sub view needed inside the ShortenListingViewController specially the collection view
final class ShortenLinksListView: UIView, ViewConfiguration {
    
    // MARK: Subviews
    lazy var linksCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
    lazy var bottomControlsView = BottomControlsView()
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
    
    func addSubViews() {
        [linksCollectionView, bottomControlsView, activityIndicationView].forEach{
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            linksCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            linksCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            linksCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            linksCollectionView.bottomAnchor.constraint(equalTo: bottomControlsView.topAnchor),
            
            bottomControlsView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            bottomControlsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomControlsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            activityIndicationView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50),
            activityIndicationView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
