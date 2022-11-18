//
//  SceneDelegate.swift
//  Meetlify BLE
//
//  Create by Erinson Villarroel  on 11/09/2020.
//  Copyright © 2020 Meetbit. All rights reserved.
//

import UIKit
import SwiftUI
import PartialSheet

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let sheetManager: PartialSheetManager = PartialSheetManager()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        // Create the SwiftUI view that provides the window contents.
        let defaults = UserDefaults.standard
//        defaults.setValue("c205d66c-ca8e-4834-911b-d990e77ad6b0", forKey: AppDelegate.USER_ID)
        let myId = defaults.string(forKey: AppDelegate.USER_ID)
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            if (myId != nil) {
                do {
                    let userDataHolder = UserDataHolder()
                    try userDataHolder.load()
                    window.rootViewController = UIHostingController(rootView: MainView().environmentObject(userDataHolder))
                } catch {
                    print(error)
                }
            } else {
                window.rootViewController = UIHostingController(rootView: LoginView().environmentObject(sheetManager))
            }
            
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

