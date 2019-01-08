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
    let currencySymbol = ["A$", "R$", "C$", "¥", "€", "£", "HK$", "Rp", "₪", "₹", "¥", "Mex$", "kr", "$", "zł", "lei", "₽", "kr", "S$", "$", "R"]
    var selectedCurrency = "AUD"
    var finalURLRequest = ""
    var bitcoinPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        
        greetingLbl.text = "Hello \(userDefaults.object(forKey: "Name") as? String ?? "Anonymous")!"
        
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        // set default currency to AUD
        finalURLRequest = apiURL + selectedCurrency
        getBitcoinData(url: finalURLRequest)
        selectedCurrency = currencySymbol[0]
        
        NotificationCenter.default.addObserver(self, selector: #selector(willTerminate), name: UIApplication.willTerminateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func willEnterForeground() {
        print("ENTERING FOREGROUND CURRENCYVC")
    }
    
    @objc func willTerminate() {
        print("ENTERING TERMINATE")
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: CurrencyVC.self) {
//                self.navigationController!.popToViewController(controller, animated: true)
//                break
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Choose your Currency"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9490196078, green: 0.6196078431, blue: 0.1960784314, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        sender.pulsate()
        performSegue(withIdentifier: TO_CONVERTVC, sender: nil)
    }
    
    // MARK: Request API
    func getBitcoinData(url: String) {
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    let bitcoinJSON : JSON = JSON(response.result.value!)
                    self.updateBitcoinData(json: bitcoinJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                }
        }
    }    
    
    // MARK: JSON Parsing
    func updateBitcoinData(json : JSON) {
        
        if let apiResult = json["ask"].double {
            bitcoinPrice = apiResult
        } else {
            navigationItem.title = "Error requesting bitcoin, try again."
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
        selectedCurrency = currencySymbol[row]
    }
}
