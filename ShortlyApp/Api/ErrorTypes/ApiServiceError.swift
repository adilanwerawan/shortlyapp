//
//  ApiServiceError.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation

/// Different types of error to be return during api calling
enum ApiServiceError:Error{
    case url(URLError)
    case urlRequest
    case decode(String)
}
