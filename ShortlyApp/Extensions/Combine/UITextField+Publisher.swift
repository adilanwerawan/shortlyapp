//
//  UITextField+Publisher.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import UIKit
import Combine

extension UITextField {
    /// urlTextPublisher will notifiy its Subscriber about the test change inside the textfield
    var urlTextPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField } // receiving notifications with objects which are instances of UITextFields
            .compactMap(\.text) // extracting text and removing optional values (even though the text cannot be nil)
            .eraseToAnyPublisher()
    }
}
