//
//  AppDelegate.swift
//  LearningRealm
//
//  Created by BJIT on 13/1/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: variables
    var window: UIWindow?

    // MARK: UIApplicationDelegate methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let _ = SizeConfig.init()
        
        setSplashViewController()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    // MARK: Custom methods
    
    private func setSplashViewController() {
        
    }
    
    public func setHomeViewController() {
        
    }

}
