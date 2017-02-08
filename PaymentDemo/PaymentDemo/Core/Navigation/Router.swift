//
//  Router.swift
//  PaymentDemo
//
//  Created by Evgeniy Leychenko on 06.02.17.
//  Copyright © 2017 theappsolutions.com. All rights reserved.
//

import UIKit

protocol Router {
    
    func show(viewConroller: UIViewController, in window: UIWindow?)
    func show(viewController: UIViewController, in navigationController: UINavigationController?, animated: Bool)
    func present(viewController: UIViewController, in presentingController: UIViewController, animated: Bool, completion: (() -> Void)?)
    
    func pop(viewController: UIViewController, animated: Bool)
    func popToRootViewController(in navigationController: UINavigationController?, animated: Bool)
    func dismiss(viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
}

class DefaultRouter: Router {
    
    func show(viewConroller: UIViewController, in window: UIWindow?) {
        guard let window = window else {
            return
        }
        
        window.rootViewController = viewConroller
        window.makeKeyAndVisible()
    }
    
    func show(viewController: UIViewController, in navigationController: UINavigationController?, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func present(viewController: UIViewController, in presentingController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentingController.present(viewController, animated: animated, completion: completion)
    }
    
    func pop(viewController: UIViewController, animated: Bool) {
        let _ = viewController.navigationController?.popViewController(animated: true)
    }
    
    func dismiss(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }
    
    func popToRootViewController(in navigationController: UINavigationController?, animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
