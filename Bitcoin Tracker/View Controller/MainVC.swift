//
//  MainVC.swift
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        sender.pulsate()
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(nameTextField.text, forKey: "Name")
        
        if nameTextField.text == "" {
            let ac = UIAlertController(title: "Add Name", message: "Make sure to add your name in the textfield so we may greet you better.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_CURRENCYVC, sender: nil)
        }
    }
}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
