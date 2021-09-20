//
//  ViewController.swift
//  JMMaskTextField
//
//  Created by Jota Melo on 01/05/2017.
//  Copyright (c) 2017 Jota Melo. All rights reserved.
//

import UIKit
import JMMaskTextField

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: JMMaskTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.textFieldDidChange(note:)), name: UITextField.textDidChangeNotification, object: nil)
        
        textField.onTextChanged = { (textField) in
            print("here \(textField.text)")
            print("unmasked \(textField.unmaskedText)")
        }
    }
    
    @objc func textFieldDidChange(note: Notification) {

        print("here")
    
    }
    
}
