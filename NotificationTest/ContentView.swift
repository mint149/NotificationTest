//
//  ContentView.swift
//  NotificationTest
//
//  Created by hato on 2021/05/02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            // 日付フォーマット
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .medium
            dateFormatter.dateStyle = .medium
            dateFormatter.locale = Locale(identifier: "ja_JP")
     
            // 現在時刻の1分後に設定
            let date2 = Date(timeInterval: 60, since: date)
            let targetDate = Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: date2)
     
            let dateString = dateFormatter.string(from: date2)
            print(dateString)
     
            // トリガーの作成
            let trigger = UNCalendarNotificationTrigger.init(dateMatching: targetDate, repeats: false)
     
            // 通知コンテンツの作成
            let content = UNMutableNotificationContent()
            content.title = "iPhoneが爆発しました。"
            content.body = ""
            content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "explosion.mp3"))

            // 通知リクエストの作成
            let request = UNNotificationRequest.init(
                    identifier: "CalendarNotification",
                    content: content,
                    trigger: trigger)
            
            // 通知リクエストの登録
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
        }) {
            Text("セットする")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
