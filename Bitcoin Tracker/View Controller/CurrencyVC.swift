//
//  CurrencyVC.swift
//  Bitcoin Tracker
//
//  Created by Hannie Kim on 1/6/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class CurrencyVC: UIViewController {

    // Outlets
    @IBOutlet weak var greetingLbl: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Variables
    let apiURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        greetingLbl.text = userDefaults.object(forKey: "Name") as? String
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

}

extension CurrencyVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    
}
