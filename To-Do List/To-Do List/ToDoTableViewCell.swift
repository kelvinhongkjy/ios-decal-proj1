//
//  ToDoTableViewCell.swift
//  To-Do List
//
//  Created by Kelvin Hong on 10/15/16.
//  Copyright © 2016 Kelvin Hong. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    var item: ToDoItem? = nil {
        didSet {
            if item != nil {
                self.titleLabel.text = item!.title
                self.detailLabel.text = item!.description
            }
        }
    }
    var onStateChanged: ((ToDoTableViewCell) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if item != nil {
            self.titleLabel.text = item!.title
            self.detailLabel.text = item!.description
        }
    }

    @IBAction func onTap(_ sender: AnyObject) {
        if let item = self.item {
            if item.completeDate == nil {
                item.completeDate = Date()
            } else {
                item.completeDate = nil
            }
            if self.onStateChanged != nil {
                self.onStateChanged!(self)
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
