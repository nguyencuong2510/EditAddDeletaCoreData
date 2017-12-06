//
//  ViewController.swift
//  EditAddDeletaCoreData
//
//  Created by nguyencuong on 12/6/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.text = person?.name
    }
    @IBAction func editButtom(_ sender: UIButton) {
        person?.name = textField.text
        AppDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }
}

