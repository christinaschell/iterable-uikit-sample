//
//  MobileInboxViewController.swift
//  IterableUIKitSample
//
//  Created by Christina Schell on 7/8/21.
//

import Foundation
import IterableSDK

class MobileInboxViewController: IterableInboxNavigationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.noMessagesTitle = "No saved messages" // cannot change color?
        self.noMessagesBody = "Check again later!"
    }
    
}
