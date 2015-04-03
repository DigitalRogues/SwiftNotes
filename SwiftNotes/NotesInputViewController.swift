//
//  SecondViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 20/10/14.
//  Copyright (c) 2014 Sebastian Andersen. All rights reserved.
//

import UIKit

class NotesInputViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
      
        title = "Note Entry"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: "presentLeftMenuViewController")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveNote")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .Plain, target: self, action: "presentRightMenuViewController")
        
    }
    
    func saveNote ()
    {
        println("yup")
        let db = DBController.sharedInstance
        db.insertNote(["note":"testing"])
        db.sync()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}