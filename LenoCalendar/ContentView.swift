//
//  ContentView.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/4.
//

import SwiftUI

struct ContentView: View {
    private let calendar: Calendar
    private let monthFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    private let fullFormatter: DateFormatter
    
    @State private var selectedDate = Self.now
    private static var now = Date()
    
    init(calendar: Calendar) {
        self.calendar = calendar
        self.monthFormatter = DateFormatter(calendar: calendar, dateStyle: .full)
        self.dayFormatter = DateFormatter(calendar: calendar, dateFormatter: "d")
        self.weekDayFormatter = DateFormatter(calendar: calendar, dateFormatter: "E")
        self.fullFormatter = DateFormatter(calendar: calendar, dateFormatter: "YYYY-MM-DD")
    }
    
    var body: some View {
        CalendarView(date: $selectedDate, calendar: calendar) { date in
            DateView(date: date, calendar: calendar, formatter: dayFormatter, selectedDate: $selectedDate)
        } header: { date in
            Text(weekDayFormatter.string(from: date))
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Color("secondaryText"))
                .frame(width: 48)
                .padding(.vertical, 12)
        } title: { date in
            HStack {
                Button {
                    guard let newDate = calendar.date(byAdding: .month, value: -1, to: selectedDate)
                    else {
                        return
                    }
                    selectedDate = newDate
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                }
                .buttonStyle(.plain)
                .frame(width: 24, height: 24)
                
                Spacer()
                Text(monthFormatter.string(from: date))
                    .font(.system(size: 16, weight: .semibold))
                    .onTapGesture(count: 2) {
                        selectedDate = Date.now
                    }
                Spacer()
                
                Button {
                    guard let newDate = calendar.date(byAdding: .month, value: 1, to: selectedDate)
                    else {
                        return
                    }
                    selectedDate = newDate
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 16))
                }
                .buttonStyle(.plain)
                .frame(width: 24, height: 24)
            }
            .foregroundColor(Color("primaryText"))
            .frame(height: 24)
        } trailing: { date in
            DateView(date: date, calendar: calendar, formatter: dayFormatter, selectedDate: $selectedDate)
                .opacity(0.3)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(calendar: Calendar(identifier: .gregorian))
    }
}
