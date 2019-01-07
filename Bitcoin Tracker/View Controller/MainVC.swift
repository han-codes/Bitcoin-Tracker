//
//  ViewController.swift
//  Bitcoin Tracker
//
//  Created by Hannie Kim on 1/6/19.
//  Copyright © 2019 Hannie Kim. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    // Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        
//        let userDefaults = UserDefaults.standard
//        userDefaults.object(forKey: "Name") as? String
    }

    @IBAction func submitBtn(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nameTextField.text, forKey: "Name")
        
        performSegue(withIdentifier: TO_CURRENCYVC, sender: nil)
    }
    
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
