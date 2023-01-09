//
//  GeneralSettingView.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/9.
//

import SwiftUI
import LaunchAtLogin

struct GeneralSettingView: View {
    var body: some View {
        Form {
            LaunchAtLogin.Toggle {
                Text("开机自启动")
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
