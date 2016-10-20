//
//  ToDoTableViewController.swift
//  To-Do List
//
//  Created by Kelvin Hong on 10/15/16.
//  Copyright © 2016 Kelvin Hong. All rights reserved.
//

import UIKit

class ToDoItem {
    public var title: String = ""
    public var description: String = ""
    public var completeDate: Date? = nil
}

class ToDoTableViewController: UITableViewController {

    var outstandingItems: Array<ToDoItem> = []
    var completedItems: Array<ToDoItem> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: self.updateItems)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addItem(_ item: ToDoItem?) {
        if let i = item {
            if i.completeDate != nil {
                self.completedItems.append(i)
            } else {
                self.outstandingItems.append(i)
            }
            self.tableView.reloadData()
        }
    }
    
    func updateItems(_ _:Timer) {
        var updated = false
        var updatedItems: Array<ToDoItem> = []
        for item in self.completedItems {
            if let d = item.completeDate {
                if d.timeIntervalSinceNow > -60*60*24 {
                    updatedItems.append(item)
                } else {
                    updated = true
                }
            }
        }
        if updated {
            self.completedItems = updatedItems
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.outstandingItems.count
        } else {
            return self.completedItems.count
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To-Do"
        } else {
            return "Completed"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoTableViewCell
        let items = indexPath.section == 0 ? self.outstandingItems : self.completedItems
        cell.item = items[indexPath.row]
        if indexPath.section == 1 {
            cell.backgroundColor = tableView.backgroundColor
        } else {
            cell.backgroundColor = UIColor.white
        }
        cell.onStateChanged = {(_ cell: ToDoTableViewCell) -> () in
            let indexPath = tableView.indexPath(for: cell)!
            if cell.item!.completeDate != nil {
                tableView.beginUpdates()
                let item = self.outstandingItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.completedItems.insert(item, at: 0)
                let path = IndexPath(row: 0, section: 1)
                tableView.insertRows(at: [path], with: .left)
                tableView.endUpdates()
            } else {
                tableView.beginUpdates()
                let item = self.completedItems.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.outstandingItems.append(item)
                let path = IndexPath(row: self.outstandingItems.count-1, section: 0)
                tableView.insertRows(at: [path], with: .left)
                tableView.endUpdates()
            }
        }
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            if indexPath.section == 0 {
                self.outstandingItems.remove(at: indexPath.row)
            } else {
                self.completedItems.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "AddSegue" {
            let vc: NewToDoViewController = segue.destination as! NewToDoViewController
            vc.onCreate = self.addItem
        } else if segue.identifier == "StatsSegue" {
            let vc: StatsViewController = segue.destination as! StatsViewController
            vc.num = self.completedItems.count
        }
    }


}
