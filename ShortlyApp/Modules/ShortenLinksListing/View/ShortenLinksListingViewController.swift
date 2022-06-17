//
//  InputListingViewController.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import UIKit
import Combine

// MARK: ShortenLinksListingViewController has been implemented
/// Purpose: Showing the list of saved shorten url from the database using its view model
final class ShortenLinksListingViewController: UIViewController {

    internal typealias DataSource = UICollectionViewDiffableDataSource<ShortenLinksListingViewModel.Section, SavedLink>
    internal typealias Snapshot = NSDiffableDataSourceSnapshot<ShortenLinksListingViewModel.Section, SavedLink>
    
    internal var contentView = ShortenLinksListView()
    internal var viewModel:ShortenLinksListingViewModel
    internal var bindings = Set<AnyCancellable>()
    private var dataSource:DataSource!
    
    init(viewModel:ShortenLinksListingViewModel = ShortenLinksListingViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTargets()
        setupCollectionView()
        configureDataSource()
        setupBindings()
        self.title = viewModel.navigationTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    private func setupCollectionView(){
        contentView.linksCollectionView.register(ShortenLinkCell.self, forCellWithReuseIdentifier: ShortenLinkCell.identifier)
    }
    
    internal func updateSections(){
        var snapshot = Snapshot()
        snapshot.appendSections([.shortenUrls])
        snapshot.appendItems(viewModel.savedLinksArray)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureDataSource(){
        dataSource = DataSource(
            collectionView: contentView.linksCollectionView,
            cellProvider: { (collectionView, indexPath, shortenURL) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShortenLinkCell.identifier, for: indexPath) as? ShortenLinkCell
                cell?.viewModel = ShortenLinkCellViewModel(shortenURL: shortenURL)
                return cell
        })
    }
}
