//
//  EditViewController.swift
//  iosFinal-Chuck
//
//  Created by Chucks Mac Book on 11/17/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var firstText: String?
    var lastText: String?
    var phoneText: String?
    
    var vcTitle: String = ""
    var addDelegate: ContactDelegate?
    var indexPath: NSIndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.text = firstText
        lastTextField.text = lastText
        phoneTextField.text = phoneText
        
        if let ip = indexPath {
            self.title = "Edit Contact"
        } else {
            self.title = "Add Contact"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        print("saved")
        if let ip = indexPath {
           addDelegate?.addContact(by: sender, firstName: firstTextField.text!, lastName:lastTextField.text!, phoneNumber: phoneTextField.text!, indexPath: ip)
        } else {
            addDelegate?.addContact(by: sender, firstName: firstTextField.text!, lastName:lastTextField.text!, phoneNumber: phoneTextField.text!, indexPath: nil)
        }
       
        //        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}
