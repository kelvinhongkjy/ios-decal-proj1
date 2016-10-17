//
//  StatsViewController.swift
//  To-Do List
//
//  Created by Kelvin Hong on 10/15/16.
//  Copyright © 2016 Kelvin Hong. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    public var num: Int = 0
    @IBOutlet weak var numLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.numLabel.text = String(num)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
