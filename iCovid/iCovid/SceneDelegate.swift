//
//  SceneDelegate.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let defaults = UserDefaults.standard


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
        
        //MARK: - Local notification
        
        if !defaults.bool(forKey: update_url){
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            content.title = "Tình hình Covid-19 Việt Nam"
            content.subtitle = "Cập nhật ngay tình hình"
            content.body = "\(defaults.integer(forKey: update_url)) Hãy nhớ tuân thủ nghiêm ngặt các khuyến nghị của chính quyền địa phương và giữ an toàn"
            var dateComp = DateComponents()
            dateComp.hour = 1
            dateComp.minute = 0
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComp, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error{
                    print("Thông báo lỗi: \(error)")
                }
            }
            defaults.set(true, forKey: update_url)
        }
    }


}

