//
//  Quotes.swift
//  wisdom
//
//  Created by Алексей Попроцкий on 22.07.2022.
//

import Foundation
import FirebaseDatabase

struct QuotesModel {
    
    var quote: String = ""
    var author: String = ""
    var isFavourite = false
    var id = UUID().uuidString
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }

    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String : AnyObject]
        quote = snapshotValue["quotetext"] as! String
        author = snapshotValue["author"] as! String
        isFavourite = snapshotValue["isfavourite"] as! Bool
        id = snapshotValue["id"] as! String
    }
}
