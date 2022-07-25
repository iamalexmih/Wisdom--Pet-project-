//
//  ViewController.swift
//  wisdom
//
//  Created by Алексей Попроцкий on 22.07.2022.
//

import UIKit
import FirebaseCore
import FirebaseDatabase

class ViewController: UIViewController {

    let quotes = Quotes()
    
    @IBOutlet weak var labelQuotes: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var textLabelQuotes: UITextView!
    @IBOutlet weak var labelButtonNext: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Database.database().reference().child("quotes").setValue(["quotestext" : "Что разум человека может постигнуть и во что он может поверить, того он способен достичь.", "author" : "Наполеон Хилл, журналист и писатель."])
        updateTextLabel()
    }

    @IBAction func buttonNextQuotes(_ sender: UIButton) {
        updateTextLabel()
    }
    
    @IBAction func gestureNextQuotes(_ sender: UISwipeGestureRecognizer) {
        updateTextLabel()
    }
    
    func updateTextLabel() {
        textLabelQuotes.text = " \" \(quotes.quotesStorage.randomElement()![0]) \""
        labelAuthor.text = quotes.quotesStorage.randomElement()![1]
        textLabelQuotes.sizeToFit()
    }
    
    func updateLabel() {
        labelQuotes.text = quotes.quotesStorage.randomElement()![0]
        labelAuthor.text = quotes.quotesStorage.randomElement()![1]
    }
}

