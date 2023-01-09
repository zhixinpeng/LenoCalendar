//
//  SettingView.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/9.
//

import SwiftUI

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    
    var body: some View {
        TabView {
            GeneralSettingView()
                .tabItem {
                    Label("通用", systemImage: "gear")
                }
                .tag(Tabs.general)
            GeneralSettingView()
                .tabItem {
                    Label("高级", systemImage: "star")
                }
                .tag(Tabs.advanced)
        }
        .padding(20)
        .frame(width: 375, height: 150)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
