//
//  ContentView.swift
//  SwiftUIThinking
//
//  Created by Mohamed Sliem on 29/09/2025.
//

import SwiftUI
import Observation
import UserNotifications
import CoreLocation


struct PushLocalNotificationView: View {
    
    @State var notificationAuthorizationManager = NotificationAuthorizationManager()
    
    let notificationPusher = NotificationPushManager()
    
    var body: some View {
        VStack {
            Text("Notification Permission Check: \(notificationAuthorizationManager.permission)")
            pushNotificationButton
        }
        .onAppear {
            notificationAuthorizationManager.checkAuthorizationStatus()
        }
    }
    
    
    private var pushNotificationButton: some View {
        Button {
            pushNotification()
        } label: {
            Text("Push Notification")
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
    
    
    private func pushNotification() {
        notificationPusher.pushInstantNotification(
            title: "Testing Notification",
            body: "Testing Notification Body (from SwiftUI_Thinking)"
        )
    }
    
}

@Observable
final class NotificationAuthorizationManager: NSObject {
    
    let center = UNUserNotificationCenter.current()
    var permission = false
    
    func checkAuthorizationStatus() {
        Task {
            let settings = await center.notificationSettings()
            switch settings.authorizationStatus {
            case .notDetermined:
                permission = await askForNotificationPermission()
            case .authorized, .provisional:
                permission = true
            default:
                permission = await askForNotificationPermission()
            }
        }
    }
    
    private func askForNotificationPermission() async -> Bool {
        do {
            let result = try await center.requestAuthorization(options: [.alert, .badge, .sound])
            return result
        } catch {
            print("askForNotificationPermission")
            print(error.localizedDescription)
        }
        return false
    }
    
}

final class NotificationPushManager: NSObject, UNUserNotificationCenterDelegate {
    
    let center = UNUserNotificationCenter.current()
    
    override init() {
        super.init()
        center.delegate = self
    }
    
    
    func pushInstantNotification(title: String, body: String) {
        let content = makeNotificationContentInstance(title: title, body: body)
        let request = createNotificationRequest(content)
        addNotificationRequest(request)
    }
    
    
    private func makeNotificationContentInstance(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.defaultCritical
        content.badge = 10
        return content
    }
    
    
    private func createNotificationRequest(_ content: UNMutableNotificationContent) -> UNNotificationRequest {
        
        // Trigger Types
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: DateComponents(), repeats: false) // schedule by date
        let locationTrigger = UNLocationNotificationTrigger(region: .init(), repeats: false)

        let identifier: NotificationIdentifier = LocalNotificationIdentifier()
        // Request
        let request = UNNotificationRequest(identifier: identifier.identifier, content: content, trigger: timeTrigger)
        return request
    }
    
    
    private func addNotificationRequest(_ request: UNNotificationRequest) {
        Task {
            do {
                try await center.add(request)
            } catch {
                print("addNotificationRequest")
                print(error)
            }
        }
    }
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {
        return [.banner, .sound, .badge]
    }

    @MainActor
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("Push Notification Received")
    }
}


protocol NotificationIdentifier {
    var identifier: String { get set }
}

struct LocalNotificationIdentifier: NotificationIdentifier {
    var identifier: String = "swiftui.thinking.local.notification"
}
