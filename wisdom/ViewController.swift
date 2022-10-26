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
        ref = Database.database().reference().child("quotes")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadScreen()
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
    }
    
    
    private func actions() {
        randomQuotesModel = StorageManagerFirebase.shared.randomLocalQuotesModel()
        updateLabel()
    }
    
    
    private func loadScreen() {
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
    
    
    private func updateLabel() {
        textLabelQuotes?.text = " \" \(randomQuotesModel?.quote ?? "Ups...") \""
        labelAuthor.text = randomQuotesModel?.author
    }
}

