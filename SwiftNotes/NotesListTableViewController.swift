//
//  NotesListTableViewController.swift
//  SwiftNotes
//
//  Created by punk on 4/1/15.
//  Copyright (c) 2015 Digital Rogues. All rights reserved.
//

import UIKit


class NotesListTableViewController: UITableViewController {
    
    var mainArray:[AnyObject] = Array()
   
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(false)
        
        let db = DBController.sharedInstance
        mainArray = db.getNotes() 
        
        //sort array by date, this is ugly and there's gotta be a better way
        mainArray.sort { (this:AnyObject, that:AnyObject) -> Bool in
            let date1:Dictionary = this.fields //fields is property on DBRecord
            let date2:Dictionary = that.fields
            
            let check1 = date1["date"] as! String
            let check2 = date2["date"] as! String
            return check1 > check2
        }
        
            self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return mainArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        let record = mainArray[indexPath.row] as! DBRecord
        cell.textLabel!.text = record["title"] as? String
        cell.detailTextLabel!.text = record["date"] as? String
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        println(sender)
        
        let index = tableView.indexPathForSelectedRow()?.row
        
        let stuff = mainArray[index!] as! DBRecord
            
        
    }
    

}
