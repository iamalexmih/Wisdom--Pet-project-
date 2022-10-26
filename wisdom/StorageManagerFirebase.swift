//
//  SaveQuoteFirebase.swift
//  wisdom
//
//  Created by Алексей Попроцкий on 25.07.2022.
//

import Foundation
import FirebaseDatabase

class StorageManagerFirebase {
    
    static let shared = StorageManagerFirebase()
    
    private var arrayQuotesLocal: [QuotesModel] = []
    
    
    func randomLocalQuotesModel() -> QuotesModel {
        guard let randomLocalQuotesModel = arrayQuotesLocal.randomElement() else {
            //придумать одну цитату по дефолту, на случай ошибки. Цитата должна быть лучшая.
            return QuotesModel(quote: "Текст лучшей цитаты", author: "Лучший автор")
        }
        return randomLocalQuotesModel
    }

    
    func loadData(ref: DatabaseReference, completion: @escaping ([QuotesModel]?) -> Void) {
        ref.observe(.value) { [weak self] snapshot in
            guard let value = snapshot.value, snapshot.exists() else {
                print("snapshot Quotes was not got")
                return
            }
            var arrayQuotesLoaded: [QuotesModel] = []
            for item in snapshot.children {
                let loadQuote = QuotesModel(snapshot: item as! DataSnapshot)
                arrayQuotesLoaded.append(loadQuote)
            }
            self?.arrayQuotesLocal = arrayQuotesLoaded
            completion(arrayQuotesLoaded)
        }
    }
}

