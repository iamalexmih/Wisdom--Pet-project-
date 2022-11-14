//
//  ViewController.swift
//  wisdom
//
//  Created by Алексей Попроцкий on 22.07.2022.
//

import UIKit
import FirebaseCore
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    private var ref: DatabaseReference!
    private var refID: DatabaseReference!
    private var quoteLoad: QuotesModel?
    private var countQuotes: Int!
    private var randomQuotesModel: QuotesModel?
    
    
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var textLabelQuotes: UITextView!
    @IBOutlet weak var labelButtonNext: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configStartScreen()
        
        Auth.auth().signInAnonymously { result, err in
            if let err = err {
                print("error = \(err.localizedDescription)")
                return
            }
            print("Success")
        }
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                print("User is nil")
                //Auth.auth().signInAnonymously()
            } else {
                print("User exist!")
                self.loadScreen()
            }
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - IBAction

    @IBAction func buttonNextQuotes(_ sender: UIButton) {
        actions()
    }
    
    @IBAction func gestureNextQuotes(_ sender: UISwipeGestureRecognizer) {
        actions()
    }
    
    
    // MARK: - Helpers functions
    
    private func configStartScreen() {
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        labelAuthor.isHidden = true
        textLabelQuotes.isHidden = true
        labelButtonNext.isHidden = true
        labelButtonNext.layer.cornerRadius = 28
        labelButtonNext.layer.masksToBounds = true
    }
    
    
    private func actions() {
        randomQuotesModel = StorageManagerFirebase.shared.randomLocalQuotesModel()
        updateLabel()
    }
    
    
    private func loadScreen() {
        print(#function)
        ref = Database.database().reference().child("quotes")
        print("ref = \(ref)")
        StorageManagerFirebase.shared.loadData(ref: ref) { [weak self] arrayQuotesHelpers in
            self?.randomQuotesModel = arrayQuotesHelpers?.randomElement()
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.updateUI()
            }
        }
    }


    private func updateUI() {
        updateLabel()
        textLabelQuotes.isHidden = false
        labelAuthor.isHidden = false
        labelButtonNext.isHidden = false
    }
    
    
    private func animateLabel(textLabelQuotes: UITextView,
                              labelAuthor: UILabel,
                              randomQuotesModel: QuotesModel) {

        UIView.transition(with: textLabelQuotes,
                          duration: 0.7,
                          options: .transitionCrossDissolve) {
            textLabelQuotes.text = " \" \(randomQuotesModel.quote) \""
        }
        
        UIView.transition(with: labelAuthor,
                          duration: 0.7,
                          options: .transitionCrossDissolve) {
            labelAuthor.text = randomQuotesModel.author
        }
    }
    
    
    private func updateLabel() {
        animateLabel(textLabelQuotes: textLabelQuotes,
                     labelAuthor: labelAuthor,
                     randomQuotesModel: randomQuotesModel ?? QuotesModel(quote: "", author: ""))
    }
}

