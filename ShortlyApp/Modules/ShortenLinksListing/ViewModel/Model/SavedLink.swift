//
//  SavedLink.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation

struct SavedLink:Hashable, Identifiable{
    var id:UUID = UUID()
    var fullShortLink : String! = "not available" // default value
    var originalLink : String! = "not available" // default value
}
