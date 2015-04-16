//
//  SecondViewController.swift
//  SSASideMenuExample
//
//  Created by Sebastian Andersen on 20/10/14.
//  Copyright (c) 2014 Sebastian Andersen. All rights reserved.
//

import UIKit

class NotesInputViewController: UIViewController, SSASideMenuDelegate {
    
    
    @IBOutlet var noteTitle: UITextField!
    @IBOutlet var notesInputTextView: UITextView!
    var noteObject:NoteObject!
    var aniButton:FRDLivelyButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Note Entry"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .Plain, target: self, action: "presentLeftMenuViewController")
        
        aniButton = FRDLivelyButton(frame: CGRectMake(0, 0, 36, 28))
        aniButton.setStyle(kFRDLivelyButtonStyleHamburger, animated: false)
        aniButton.addTarget(self, action: "leftControllerButton", forControlEvents: UIControlEvents.TouchUpInside)
        aniButton.options = [kFRDLivelyButtonColor:UIColor(red:0.847, green:0.866, blue:0.647, alpha:1),kFRDLivelyButtonLineWidth:1.0]
        let barButton = UIBarButtonItem(customView: aniButton)
        navigationItem.leftBarButtonItem = barButton
        
//        FRDLivelyButton *button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0,0,36,28)];
//        [button setStyle:kFRDLivelyButtonStyleHamburger animated:NO];
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//        self.navigationItem.rightBarButtonItem = buttonItem;
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveNote")
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right", style: .Plain, target: self, action: "presentRightMenuViewController")
        
        //set up textkit?
        notesInputTextView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        noteTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
    }
    
    func leftControllerButton()
    {
        aniButton.setStyle(kFRDLivelyButtonStyleArrowLeft, animated: true)
        presentLeftMenuViewController()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        aniButton.setStyle(kFRDLivelyButtonStyleHamburger, animated: true)
        
       if((noteObject) != nil)
       {
            noteTitle.text = noteObject.title
            notesInputTextView.text = noteObject.note
        }
        
        
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