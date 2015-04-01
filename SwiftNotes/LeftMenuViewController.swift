//
//  LeftMenuViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 20/10/14.
//  Copyright (c) 2014 Sebastian Andersen. All rights reserved.
//

import Foundation
import UIKit

////I think we'll have to use the app delegate as a central point so the viewcontrollers arent reinited each time they are called. its a bad thing to do but I dont know of a better way
//         let view = appDelegate.rootView
class LeftMenuViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.frame = CGRectMake(20, (self.view.frame.size.height - 54 * 5) / 2.0, self.view.frame.size.width, 54 * 5)
        tableView.autoresizingMask = .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleWidth
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.opaque = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}


// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
   
        let titles: [String] = ["Notes List", "Add Note", "Profile", "Settings", "Log Out"]
        
        let images: [String] = ["IconHome", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
        cell.textLabel?.textColor = UIColor.blackColor()
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .None
        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
     
        switch indexPath.row {
        case 0:
            
            //Notes
            let sb:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let view = sb.instantiateViewControllerWithIdentifier("noteListView") as! UIViewController
           sideMenuViewController?.contentViewController = view
                sideMenuViewController?.hideMenuViewController()
            break
        case 1:
            
            let view = appDelegate.rootView as UIViewController
            sideMenuViewController?.contentViewController = view
            sideMenuViewController?.hideMenuViewController()
            break
            
        default:
            break
        }
        
        
    }
    
}
    