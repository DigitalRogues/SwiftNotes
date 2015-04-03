//
//  DBController.swift
//  SwiftNotes
//
//  Created by punk on 4/1/15.
//  Copyright (c) 2015 Digital Rogues. All rights reserved.
//

import UIKit

class DBController: NSObject {
   
    //singletons are  for some reason frowned upon, but I still find it an indespinsible tool for specific types of classes, generally utility classes like networking or in this case dropbox
    //this particular stanza was pulled from and explained here http://www.raywenderlich.com/86477/introducing-ios-design-patterns-in-swift-part-1
    class var sharedInstance: DBController {
        struct Singleton {
            static let instance = DBController()
            
        }
        return Singleton.instance
    }
    
    
    var dataStore = DBDatastore()
    var notesTable = DBTable()
    
    override  init() {
        //this call in particular can only be called once. not sure why there isnt a way in the dropbox api to get open datastores unless I missed it.
            dataStore = DBDatastoreManager.sharedManager().openDefaultDatastore(nil)
            println(dataStore)
            notesTable = dataStore.getTable("notes")
    }
    
    func close (){
        dataStore.close()
    }
    
    func getNotes () -> Array<AnyObject>
    {
        let results = notesTable.query(nil, error: nil)
        return results

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
