//
//  ViewController.swift
//  shortlyapp
//
//  Created by MacBook on 17/05/2022.
//

import UIKit
import Combine

// MARK: InputLinkViewController has been implemented
/// Purpose: Taking the input from the user and through its view model validating the url and calling of shortening the url api

final class InputLinkViewController: UIViewController {

    /// Initializing the contentView named  InputLinkView which contains  textField for url input and button to proceed etc.
    internal lazy var contentView = InputLinkView()
    // MARK: ViewModel for InputLinkViewController
    // Initializer dependency injection
    internal var viewModel:InputLinkViewModel
    
    internal var bindings = Set<AnyCancellable>()
    
    init(viewModel:InputLinkViewModel = InputLinkViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ViewController lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.resetFields()
        // These functions has been implemented in the InputListViewController+Extension
        setupTargets()
        setupBindings()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        for binding in bindings{
            binding.cancel()
        }
        bindings.removeAll()
        // Used for hiding the keyboard
        view.endEditing(true)
    }
    
    func navigateToListView(){
        DispatchQueue.main.async { [unowned self] in
            let shortenLinksListView = ShortenLinksListingViewController()
            self.navigationController?.pushViewController(shortenLinksListView, animated: true)
        }
    }
}
