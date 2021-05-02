//
//  ContentView.swift
//  NotificationTest
//
//  Created by hato on 2021/05/02.
//

import SwiftUI

struct ContentView: View {
    @State var selectionDate = Date()
    var body: some View {
        VStack{
            DatePicker("", selection: $selectionDate)
                .labelsHidden()
                .datePickerStyle(GraphicalDatePickerStyle())
            Button(action: {
                // 日付フォーマット
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = .medium
                dateFormatter.dateStyle = .medium
                dateFormatter.locale = Locale(identifier: "ja_JP")
                
                let targetDate = Calendar.current.dateComponents(
                    [.year, .month, .day, .hour, .minute],
                    from: selectionDate)
                
                let dateString = dateFormatter.string(from: selectionDate)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
