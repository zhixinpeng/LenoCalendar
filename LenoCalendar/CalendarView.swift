//
//  CalendarView.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/6.
//

import SwiftUI

public struct CalendarView<Day: View, Header: View, Title: View, Trailing: View>: View {
    @Binding private var date: Date
    private var calendar: Calendar
    private let content: (Date) -> Day
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    private let trailing: (Date) -> Trailing
    
    private let daysInWeek = 7
    
    public init(date: Binding<Date>, calendar: Calendar, content: @escaping (Date) -> Day, header: @escaping (Date) -> Header, title: @escaping (Date) -> Title, trailing: @escaping (Date) -> Trailing) {
        self._date = date
        self.calendar = calendar
        self.content = content
        self.header = header
        self.title = title
        self.trailing = trailing
    }
    
    public var body: some View {
        let month = date.startOfMonth(using: calendar)
        let days = makeDays()
        
        return LazyVGrid(columns: Array(repeating: GridItem(.fixed(48)), count: daysInWeek), spacing: 2) {
            Section(header: title(date)) {
                ForEach(days.prefix(daysInWeek), id: \.self, content: header)
                ForEach(days, id: \.self) { date in
                    if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                        content(date)
                    } else {
                        trailing(date)
                    }
                }
            }
        }
        .padding()
        .contextMenu {
            Button {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            } label: {
                Label("设置", systemImage: "slider.horizontal.3")
            }
            
            Button {
                NSApplication.shared.terminate(nil)
            } label: {
                Label("退出", systemImage: "power")
            }
        }
    }
}

private extension CalendarView {
    func makeDays() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else {
            return []
        }
        
        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        return calendar.generateDays(for: dateInterval)
    }
}
