//
//  HistoryShortenUrls+Extension.swift
//  shortlyapp
//
//  Created by MacBook on 19/05/2022.
//

import Foundation
import CoreData

extension HistoryShortenUrls{
    static func fetchShortenUrls(context:NSManagedObjectContext) -> [HistoryShortenUrls]?{
        // Create a fetch request for a specific Entity type
        let fetchRequest: NSFetchRequest<HistoryShortenUrls>
        fetchRequest = HistoryShortenUrls.fetchRequest()
        // Get a reference to a NSManagedObjectContext
        let context = context
        // Fetch all objects of one Entity type
        do{
            let objects = try context.fetch(fetchRequest) as [HistoryShortenUrls]
            return objects
        } catch{
            return nil
        }
    }
}
