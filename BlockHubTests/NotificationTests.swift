//
//  NotificationTests.swift
//  BlockHubTests
//
//  Created by Ramazan Kalabay on 10.06.2024.
//

import XCTest
import UserNotifications
@testable import BlockHub

final class NotificationTests: XCTestCase {

    var notificationManager: AppDelegate!
        
        override func setUp() {
            super.setUp()
            notificationManager = UIApplication.shared.delegate as? AppDelegate
        }
        
        func testScheduleNotification() {
            let expectation = self.expectation(description: "Notification scheduled")
            
            let title = "Test Notification"
            let body = "This is a test notification"
            let date = Date().addingTimeInterval(10) // 10 seconds from now
            let identifier = "testNotification"
            
            notificationManager.scheduleNotification(title: title, body: body, date: date, identifier: identifier)
            
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                XCTAssertTrue(requests.contains { $0.identifier == identifier }, "Notification should be scheduled")
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5, handler: nil)
        }
        
        func testRemoveAllNotifications() {
            let expectation = self.expectation(description: "Notifications removed")
            
            // Schedule a test notification to be removed
            let title = "Test Notification"
            let body = "This is a test notification"
            let date = Date().addingTimeInterval(10)
            let identifier = "testNotification"
            
            notificationManager.scheduleNotification(title: title, body: body, date: date, identifier: identifier)
            
            // Remove all notifications
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
            UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
                XCTAssertFalse(requests.contains { $0.identifier == identifier }, "All notifications should be removed")
                expectation.fulfill()
            }
            
            waitForExpectations(timeout: 5, handler: nil)
        }

}
