//
//  DBController.swift
//  SwiftNotes
//
//  Created by punk on 4/1/15.
//  Copyright (c) 2015 Digital Rogues. All rights reserved.
//

import UIKit

class DBController: NSObject {
   
    var dataStore = DBDatastore()
    var notesTable = DBTable()
    
    
    override  init() {
        
        dataStore = DBDatastoreManager.sharedManager().openDefaultDatastore(nil)
         notesTable = dataStore.getTable("notes")
    }
    
    
    func getNotes ()
    {
        var notesTable = dataStore.getTable("notes")
    }
    
    func insertNote(dic:Dictionary<String,String>)
    {
        
        notesTable.insert(dic)
        
    }
    
    func sync()
    {
        dataStore.sync(nil)
    }
    
    
    
}
