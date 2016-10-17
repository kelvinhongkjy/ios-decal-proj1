//
//  NewToDoViewController.swift
//  To-Do List
//
//  Created by Kelvin Hong on 10/15/16.
//  Copyright © 2016 Kelvin Hong. All rights reserved.
//

import UIKit

class NewToDoViewController: UIViewController {

    public var onCreate: ((ToDoItem?) -> ())? = nil
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClickDone(_ sender: AnyObject) {
        
        if let title = self.titleField.text, let desc = self.descriptionTextView.text, let handler = self.onCreate {
            let item = ToDoItem()
            item.title = title
            item.description = desc
            handler(item)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
