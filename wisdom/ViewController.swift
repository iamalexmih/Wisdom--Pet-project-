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

    var ref: DatabaseReference!
    var refID: DatabaseReference!
    var quoteLoad: QuotesModel?
    var countQuotes: Int!
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var textLabelQuotes: UITextView!
    @IBOutlet weak var labelButtonNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("quotes")
        refID = Database.database().reference().child("countQuotes")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        loadTextQuoteDelay()
    }
    
    @IBAction func buttonNextQuotes(_ sender: UIButton) {
        loadData()
        printName()
    }
    
    @IBAction func gestureNextQuotes(_ sender: UISwipeGestureRecognizer) {
        loadData()
        printName()
    }
    
    func loadData() {
//        textLabelQuotes.sizeToFit()
        
        refID.observe(.value) { snapshot in
            guard let value = snapshot.value, snapshot.exists() else {
                print("snapshot ID was not got")
                return
            }
            self.countQuotes = value as! Int
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            let randomNumber = (1...self.countQuotes).randomElement()!
            print(randomNumber)
            self.ref.child("\(randomNumber)").observe(.value) { [weak self] snapshot in
                guard let value = snapshot.value, snapshot.exists() else {
                    print("snapshot Quotes was not got")
                    return
                }
                self?.quoteLoad = QuotesModel(snapshot: snapshot)
            }
        }
    }
    
    
    
    func printName() {
        textLabelQuotes.text = " \" \(quoteLoad!.quote) \""
        labelAuthor.text = quoteLoad?.author
    }
    
    func loadTextQuoteDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            self.textLabelQuotes.text = " \" \(self.quoteLoad!.quote) \""
            self.labelAuthor.text = self.quoteLoad?.author
        }
    }

}

