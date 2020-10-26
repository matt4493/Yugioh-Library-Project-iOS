//
//  AppDelegate.swift
//  Yugioh Library
//
//  Created by Matthew White on 9/26/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        var storyboard: UIStoryboard
        
        // instantiate the `UIWindow`
        //[self.window, setRootViewController,:someController];
       // self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        
        // Get the model name based in the extension.
        let modelName = UIDevice.current.modelName
        print("Received type: \(modelName)")
        // If device has a 5.5" screen.
        // 5.5" iPhone 6 Plus  -  "iPhone7,1": "iPhone 6 Plus",
        // 5.5" iPhone 6s Plus - "iPhone8,2": "iPhone 6s Plus",
        if (modelName.contains("5.5") != false){
            storyboard = UIStoryboard(name: "five_five_inch", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController() as! SWRevealViewController
            print("User is on an iPhone 6 Plus or 5.5\" screen.")
        }
        // If device has a 9.7" screen
        // 9.7" iPad 2           "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
        // 9.7" iPad 3           "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
        // 9.7" iPad 4           "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
        // 9.7" iPad Air         "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
        // 9.7" iPad Air 2       "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
        else if (modelName.contains("9.7") != false) {
            storyboard = UIStoryboard(name: "nine_seven_inch", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController() as! SWRevealViewController
            print("User is on an iPad 2, 3, 4, Air, or Air 2 and/or 9.7\" screen.")
        }
        // If device has a 4" screen
        // 4" iPhone 5        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
        // 4" iPhone 5C        "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
        // 4" iPhone 5S        "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
        // 4" iPhone SE    "iPhone8,4": "iPhone SE",
        // 4" iPod 5th Gen     "iPod5,1": "iPod Touch 5",
        // 4" iPod 6th Gen     "iPod7,1": "iPod Touch 6",
        else if (modelName.contains("4.0") != false) {
            storyboard = UIStoryboard(name: "four_inch", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController() as! SWRevealViewController
            print("User is a 4 inch screen.")
        }
        else if (modelName.contains("Simulator") != false) {
            storyboard = UIStoryboard(name: "five_five_inch", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController() as! SWRevealViewController
            print("User is on simulator.")
        }
        /*else if (modelName.containsString("7.9") != false) {
            storyboard = UIStoryboard(name: "seven_nine_inch", bundle: nil)
            self.window!.rootViewController = storyboard.instantiateInitialViewController() as! SWRevealViewController
            print("User is on an iPad mini 2.")
        }*/
        
        self.window!.makeKeyAndVisible()
        
        Util.copyFile("yugiohdb.jet")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

