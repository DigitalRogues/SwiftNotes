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
    
    func getNotes () -> Array<NoteObject>
    {
        let query = notesTable.query(nil, error: nil)
        
        var results:Array<NoteObject> = Array()
        for element  in query {
           results.append( dbToNote(element as! DBRecord))
        }
        
        return results

    }
    
    func insertNote(dic:Dictionary<String,AnyObject>)
    {
        notesTable.insert(dic)
    }
    
    
    /////I could probably use DBrecords directly in my view controllers, but I feel its a bit cleaner to use an object with properties instead of dictionaries and subscripts with text. Also leaves it a bit more flexible if i choose to implement a different\ backend
//    func noteToDB(NoteObject) -> DBRecord
//    {
//        
//       
//    }
    
    
    func dbToNote(record:DBRecord) -> NoteObject
    {
        
        let noteObj = NoteObject()
        
        noteObj.title = record["title"] as! String
        noteObj.note = record["note"] as! String
        noteObj.date = record["date"] as! String
        
        
        return noteObj
    }
    
    func sync()
    {
        dataStore.sync(nil)
    }
    
    
    
}
