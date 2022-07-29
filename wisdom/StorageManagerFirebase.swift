//
//  SaveQuoteFirebase.swift
//  wisdom
//
//  Created by Алексей Попроцкий on 25.07.2022.
//

import Foundation
import FirebaseDatabase

class StorageManagerFirebase {
    
    static var ref = Database.database().reference().child("quotes").child("1")
    
    static func saveQuote(quote: QuotesModel) {
        let refQuotes = ref.child(String(quote.id))
        refQuotes.setValue(["quotetext" : quote.quote, "author" : quote.author, "isfavourite" : quote.isFavourite, "id" : quote.id])
        
    }
}

