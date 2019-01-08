//
//  ConvertVC.swift
//  Bitcoin Tracker
//
//  Created by Hannie Kim on 1/6/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class ConvertVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var currencySymbolLbl: UILabel!
    @IBOutlet weak var bitcoinValueLbl: UILabel!
    
    // Variables
    var bitcoinPrice: Double!
    var selectedCurrency: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Bitcoin Value"
        
        guard let bitcoinPrice = bitcoinPrice else { return }
        bitcoinValueLbl.text = ("\(bitcoinPrice)")
        currencySymbolLbl.text = selectedCurrency        
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.6196078431, blue: 0.1960784314, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
        
    @objc func willEnterForeground() {
        navigationController?.popViewController(animated: true)
        
    }
}
