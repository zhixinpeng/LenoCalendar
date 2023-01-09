//
//  GeneralSettingView.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/9.
//

import SwiftUI
import LaunchAtLogin

struct GeneralSettingView: View {
    @AppStorage("firstWeekDay") var firstWeekDay: Int = 1
    
    var body: some View {
        Form {
            LaunchAtLogin.Toggle {
                Text("开机自启动")
            }
            Picker("一周开始于：", selection: $firstWeekDay) {
                Text("周日").tag(1)
                Text("周一").tag(2)
            }
        }
        .padding(20)
        .frame(width: 350, height: 100)
    }
}

struct GeneralSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingView()
    }
}
