//
//  CurrencyVC.swift
//  Bitcoin Tracker
//
//  Created by Hannie Kim on 1/6/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CurrencyVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var greetingLbl: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    // Variables
    let apiURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD","BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let currencySymbol = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    var selectedCurrency = "AUD"
    var finalURLRequest = ""
    var bitcoinPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        greetingLbl.text = userDefaults.object(forKey: "Name") as? String
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    
        // if currency is set to default AUD
        finalURLRequest = apiURL + selectedCurrency
        getBitcoinData(url: finalURLRequest)
        selectedCurrency = currencySymbol[0]
    }
    
    @objc func closeActivityController()  {
        
        
    }
    
    @objc func openactivity()  {
        
        //view should reload the data.
    }
    
    
    @IBAction func submitBtn(_ sender: Any) {
        performSegue(withIdentifier: TO_CONVERTVC, sender: nil)
    }
    
    // MARK: Request API
    func getBitcoinData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
//                    print("Sucess!")
                    let bitcoinJSON : JSON = JSON(response.result.value!)
                    self.updateBitcoinData(json: bitcoinJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
    }    
    
    // MARK: JSON Parsing
    func updateBitcoinData(json : JSON) {
        
        if let tempResult = json["ask"].double {
            bitcoinPrice = tempResult
            
            print("BITCOIN PRICE: \(bitcoinPrice)")
        } else {
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TO_CONVERTVC {
            if let destinationVC = segue.destination as? ConvertVC {
                if let bitcoinPrice = bitcoinPrice {
                    destinationVC.bitcoinPrice = bitcoinPrice
                    destinationVC.selectedCurrency = selectedCurrency
                }
            }
        }
    }
}

extension CurrencyVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalURLRequest = apiURL + currencyArray[row]
        getBitcoinData(url: finalURLRequest)
        if selectedCurrency == "" {
            print("EMPTY YO")
        }
        selectedCurrency = currencySymbol[row]
        print("SELECTED CURRENCY: \(selectedCurrency)")
    }
}
