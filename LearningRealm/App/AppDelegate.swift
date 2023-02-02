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
        _ = SizeConfig.init()
        
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
        let vc = SplashViewController()
        let nvc = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }
    
    public func setHomeViewController() {
        let vc = HomeViewController()
        let nvc = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }

}
