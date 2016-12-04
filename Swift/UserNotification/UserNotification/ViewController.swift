//
//  ViewController.swift
//  UserNotification
//
//  Created by John Lima on 04/12/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//  https://youtu.be/Svul_gCtzck

import UIKit
import UserNotifications

enum ActionIdentifier: String {
    case first = "firstAction"
    case second = "secondAction"
    case third = "thirdAction"
}

enum CategoryIdentifier: String {
    case first = "firstCategory"
}

enum RequestIdentifier: String {
    case first = "firstRequest"
}

enum AttachmentIdentifier: String {
    case first = "firstAttachment"
}

func showAlert(message: String, style: UIAlertControllerStyle = .alert, target: AnyObject) {
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: style)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    target.present(alert, animated: true, completion: nil)
}

class ViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private weak var notifyButton: UIBarButtonItem!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        UNUserNotificationCenter.current().delegate = self
    }

    // MARK: - Actions
    @IBAction private func createNotification() {
    
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.subtitle = "Notification Subtitle"
        content.body = "Notification Body"
        content.badge = 1
        content.categoryIdentifier = CategoryIdentifier.first.rawValue
        content.sound = UNNotificationSound.default()
        
        if let url = Bundle.main.url(forResource: "image1", withExtension: "jpg") {
            if let attachment = try? UNNotificationAttachment(identifier: AttachmentIdentifier.first.rawValue, url: url, options: nil) {
                content.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let identifier = RequestIdentifier.first.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            // handle error
        })
    }
    
    private func updateUI() {
    
        notifyButton.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)], for: .normal)
    }
}

extension ViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // some other way of handling notification
        completionHandler([.alert, .sound])
    }
}
