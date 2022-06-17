//
//  ApiConfig.swift
//  shortlyapp
//
//  Created by MacBook on 18/05/2022.
//

import Foundation

struct ApiConfig{
    // We can add multiple base urls for Production, Development and Staging here
    struct BaseURLs{
        static var productionBaseURL = "https://api.shrtco.de/v2/"
    }
    // We can add different endpoints here
    struct EndPoints{
        static var shortenURL = "shorten"
    }
}
