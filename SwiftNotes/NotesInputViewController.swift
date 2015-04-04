//
//  SecondViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 20/10/14.
//  Copyright (c) 2014 Sebastian Andersen. All rights reserved.
//

import UIKit

class NotesInputViewController: UIViewController {
    
    
    @IBOutlet var noteTitle: UITextField!
    @IBOutlet var notesInputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
      
        title = "Note Entry"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: "presentLeftMenuViewController")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveNote")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .Plain, target: self, action: "presentRightMenuViewController")
        
        //set up textkit?
        notesInputTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
    }
    
    func saveNote ()
    {
        println("yup")
        let db = DBController.sharedInstance
        
        //save date as a local date

        let localDate = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: NSDateFormatterStyle.MediumStyle, timeStyle: NSDateFormatterStyle.MediumStyle)
        
        var title = ""
        if(count(noteTitle.text) == 0)
        {
            title = localDate
        }
        
        else {
            title = noteTitle.text
        }
        db.insertNote(["title":title,"note":notesInputTextView.text,"date":localDate])
        db.sync()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}