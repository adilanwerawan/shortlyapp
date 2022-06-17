//
//  InputListView+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation
import UIKit

// MARK: Used extensions for better code structure and readabillity
extension InputLinkViewController{
    // MARK: Assigning Publishers to Subscribers
    internal func setupBindings() {
        func bindingViewToViewModel() {
            /*
             When user will be entering the url, textField's publisher will be notifing enteredURL property of InputLinkViewModel as its subscriber
             */
            contentView.bottomControlsView.inputURLTextField.urlTextPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.enteredURL, on: viewModel)
                .store(in: &bindings)
        }
        
        func bindingViewModelToView() {
            /*
             Is valid url subscribe to isValid property of shortenLinkButton and enable it once
             the url would be valid
             */
            viewModel.isURLValid
                .receive(on: RunLoop.main)
                .assign(to: \.isValid, on: contentView.bottomControlsView.shortenLinkButton)
                .store(in: &bindings)
            /*
             After api calling when view model would has been done with saving the database
             it will navigate the user to urls history listing screen
             */
            viewModel.$savedToDatabase
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] saved in
                    if saved == true{
                        self?.navigateToListView()
                    }
                })
                .store(in: &bindings)
            
            setupLoadingState()
        }
        
        bindingViewToViewModel()
        bindingViewModelToView()
    }
    
    internal func setupTargets(){
        contentView.bottomControlsView.shortenLinkButton.addTarget(self, action: #selector(shortenItButtonPressed(sender:)), for: .touchUpInside)
    }
    
    @objc internal func shortenItButtonPressed(sender: UIButton){
        viewModel.shortenURL()
    }
    
    // MARK: Different states of view models would help in presenting activity indicator as well
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
    // If api calling has been finished with error showing error alert
    private func showError(_ error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
