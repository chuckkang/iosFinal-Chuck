//
//  ViewViewController.swift
//  iosFinal-Chuck
//
//  Created by Chucks Mac Book on 11/17/17.
//  Copyright © 2017 Chucks Mac Book. All rights reserved.
//

import UIKit

class ViewViewController: UIViewController {
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var phoneTextLabel: UILabel!
    @IBOutlet weak var lastTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var firstText: String?
    var lastText: String?
    var phoneText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextLabel.text = firstText
        lastTextLabel.text = lastText
        phoneTextLabel.text = phoneText
        nameLabel.text = firstText
        // Do any additional setup after loading the view.
    }

    @IBAction func doneButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
