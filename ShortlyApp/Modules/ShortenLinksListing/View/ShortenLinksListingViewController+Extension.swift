//
//  ShortenLinksListingViewController+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation
import UIKit

// MARK: Used extensions for better code structure and readabillity
extension ShortenLinksListingViewController{
    internal func setupBindings(){
        
        func bindViewToViewModel(){
            contentView.bottomControlsView.inputURLTextField.urlTextPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.enteredURL, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView(){
            /*
             When view model will save the data into array it will notify using the savedLinksArray
             published property which will using its subscriber update the NSDiffableDataSourceSnapshot
             and UICollectionViewDiffableDataSource to render the data on collection view
             */
            viewModel.$savedLinksArray
                .receive(on:RunLoop.main)
                .sink(receiveValue: {[weak self] _ in
                    self?.updateSections()
                })
                .store(in: &bindings)
            
            viewModel.isURLValid
                .receive(on: RunLoop.main)
                .assign(to: \.isValid, on: contentView.bottomControlsView.shortenLinkButton)
                .store(in: &bindings)
            
            setupLoadingState()
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    
    internal func setupTargets(){
        contentView.bottomControlsView.shortenLinkButton.addTarget(self, action: #selector(shortenItButtonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc internal func shortenItButtonPressed(sender: UIButton){
        viewModel.shortenURL()
    }
    
    private func setupLoadingState(){
        let stateValueHandler : (InputLinkViewModelState) -> Void = { [weak self] state in
            
            switch state{
            case .loading:
                self?.contentView.startLoading()
            case .finishLoading:
                self?.contentView.finishLoading()
            case .error(let message):
                self?.contentView.finishLoading()
                self?.showError(message)
            }
        }
        
        viewModel.$state
            .receive(on: RunLoop.main)
            .sink(receiveValue: stateValueHandler)
            .store(in: &bindings)
    }
    
    private func showError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
