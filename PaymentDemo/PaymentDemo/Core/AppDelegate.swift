//
//  AppDelegate.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 03.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupAPILayer()
        startApplication()
        
        return true
    }
    
    // MARK: - Private -
    
    private func setupAPILayer() {
        if let baseURL = URL(string: API.host) {
            NetworkConfiguration.shared = NetworkConfiguration(withBaseURL: baseURL)
            RequestManager.shared = RequestManager(withConfigaration: NetworkConfiguration.shared)
            APIManager.shared = APIManager(withRequestManager: RequestManager.shared)
        }
    }
    
    private func startApplication() {
        window = UIWindow(frame: UIScreen.main.bounds)
        StartPresenter.showView(in: window)
    }
}
