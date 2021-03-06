//
//  AppDelegate.swift
//  SwiftNotes
//
//  Created by punk on 3/30/15.
//  Copyright (c) 2015 Digital Rogues. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SSASideMenuDelegate {

        
    var noteInputView:UIViewController = UIViewController()
    var window: UIWindow?
    var sb:UIStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //get the DB keys from the scheme envrionmental variables
        let dbKey = NSProcessInfo.processInfo().environment["DBKEY"] as! String
        let dbSecret = NSProcessInfo.processInfo().environment["DBSECRET"] as! String

        
        
        //init account manager //use your own Dropbox keys
        let accountManager = DBAccountManager(appKey: dbKey, secret: dbSecret)
        DBAccountManager.setSharedManager(accountManager)
        
        //set up datastores
        //if the account is linked to a user drop box then use that account, else use local store
        let account = DBAccountManager.sharedManager().linkedAccount
        if((account) != nil)
        {
            //use dropbox store
            DBDatastoreManager.setSharedManager(DBDatastoreManager(forAccount: account))
        }
        
        else {
            //use local store
            DBDatastoreManager.setSharedManager(DBDatastoreManager.localManagerForAccountManager(DBAccountManager.sharedManager()))

        }
        
        
        
        
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //MARK : Setup SSASideMenu
        
        
         noteInputView = sb.instantiateViewControllerWithIdentifier("contentViewController") as! UIViewController
        let leftMenu = sb.instantiateViewControllerWithIdentifier("leftMenu") as? UIViewController
        
        var sideMenu = SSASideMenu(contentViewController: noteInputView, leftMenuViewController: leftMenu!)
        sideMenu.backgroundImage = UIImage(named: "Background.jpg")
        sideMenu.menuPreferredStatusBarStyle = .LightContent
        sideMenu.panDirection = SSASideMenu.SSASideMenuPanDirection.EveryWhere
        sideMenu.delegate = self
        
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()

        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

