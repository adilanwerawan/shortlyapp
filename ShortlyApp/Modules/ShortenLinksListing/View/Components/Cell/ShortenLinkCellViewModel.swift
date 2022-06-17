//
//  ShortenLinkCellViewModel.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation

final class ShortenLinkCellViewModel{
    
    var originalURL: String = ""
    var shortenURL: String = ""
    
    private let shortenUrl:SavedLink
    init(shortenURL:SavedLink){
        self.shortenUrl = shortenURL
        setupFields()
    }
    
    func setupFields(){
        self.originalURL = shortenUrl.originalLink
        self.shortenURL = shortenUrl.fullShortLink
    }
}
