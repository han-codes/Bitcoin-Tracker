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

        guard let bitcoinPrice = bitcoinPrice else { return }
        bitcoinValueLbl.text = ("\(bitcoinPrice)")
        currencySymbolLbl.text = selectedCurrency
        print("BITCOIN PRICE IN COVERTVC \(bitcoinPrice)")
        
//        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        var foregroundObserver = NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    // my selector that was defined above
    @objc func willEnterForeground() {
        // do stuff
        print("🙌🏻 ENTERING THE FOREGROUND TO DISMISS VIEW CONTROLLER")
        navigationController?.popViewController(animated: true)
        
    }
//
//    @objc func didBecomeActive() {
//        print("🙌🏻 BECOMING ACTIVE YO")
//
////        dismiss(animated: true, completion: nil)
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("VIEWDIDDISAPPEAR")
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let currencyVC = storyboard?.instantiateViewController(withIdentifier: "Currency") as! CurrencyVC
//        present(currencyVC, animated: true, completion: nil)
        print("VIEWWILLAPPEAR)")
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ViewWillAppear")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
//        let currencyVC = storyboard?.instantiateViewController(withIdentifier: "Currency") as! CurrencyVC
//        present(currencyVC, animated: true, completion: nil)
        NotificationCenter.default.removeObserver(self)
        print("VIEWILLDISAPPEAR")
    }
}
