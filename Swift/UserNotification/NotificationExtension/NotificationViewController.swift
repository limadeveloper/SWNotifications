//
//  NotificationViewController.swift
//  NotificationExtension
//
//  Created by John Lima on 04/12/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    // MARK: - Properties
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.image = #imageLiteral(resourceName: "image2.jpg")
    }
    
    func didReceive(_ notification: UNNotification) {
        
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        switch response.actionIdentifier {
        case ActionIdentifier.first.rawValue: self.imageView.image = #imageLiteral(resourceName: "image1.jpg")
        case ActionIdentifier.second.rawValue: self.imageView.image = #imageLiteral(resourceName: "image2.jpg")
        case ActionIdentifier.third.rawValue: showAlert(message: "Well done action 3", style: .actionSheet, target: self)
        default:
            break
        }
        completion(.doNotDismiss)
    }

}
