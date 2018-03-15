//
//  AppDelegate.swift
//  smooch-sample
//
//  Created by Danilo Bürger on 15.03.18.
//  Copyright © 2018 Danilo Bürger. All rights reserved.
//

import UIKit
import Smooch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let rootVC = UITabBarController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        initSmooch()

        rootVC.setViewControllers([ViewController()], animated: false)

        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window

        window.backgroundColor = UIColor.black
        window.rootViewController = UINavigationController(rootViewController: rootVC)
        window.makeKeyAndVisible()

        return true
    }

    private func initSmooch() {
        let settings = SKTSettings(appId: Configuration.appId)
        settings.enableAppDelegateSwizzling = false
        settings.requestPushPermissionOnFirstMessage = false

        Smooch.initWith(settings) { error, _ in
            if let error = error {
                print(error)
            }
            self.loginSmooch()
        }
    }

    private func loginSmooch() {
        Smooch.login(Configuration.userId, jwt: Configuration.userToken()) { error, _ in
            if let error = error {
                print(error)
            }
            self.addSmooch()
        }
    }

    private func addSmooch() {
        guard var viewControllers = rootVC.viewControllers else { return }
        guard let viewController = Smooch.newConversationViewController() else { return }
        viewController.title = "Chat"
        viewControllers.append(viewController)
        rootVC.setViewControllers(viewControllers, animated: false)
    }

}
