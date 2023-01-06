//
//  Extension.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/6.
//

import SwiftUI

extension Date {
    func startOfMonth(using calendar: Calendar) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: self)) ?? self
    }
    
    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func isInSameYear(as date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(as date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameWeek(as date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }
    func isInSameDay(as date: Date) -> Bool { Calendar.current.isDate(self, inSameDayAs: date) }
    
    var isInThisYear:  Bool { isInSameYear(as: Date()) }
    var isInThisMonth: Bool { isInSameMonth(as: Date()) }
    var isInThisWeek:  Bool { isInSameWeek(as: Date()) }
    
    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday:     Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow:  Bool { Calendar.current.isDateInTomorrow(self) }
    
    var isInTheFuture: Bool { self > Date() }
    var isInThePast:   Bool { self < Date() }
    
    func getChineseDate() -> (lunar: String, festival: String?) {
        let calendar = Calendar(identifier: .chinese)
        
        let festival = Festival.getFistival(date: self)
        
        let lunar = DateFormatter(dateFormatter: "d", calendar: calendar, dateStyle: .medium).string(from: self)
        
        return (lunar, festival)
    }
}

extension Calendar {
    func generateDates(for dateInterval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates = [dateInterval.start]
        
        enumerateDates(startingAfter: dateInterval.start, matching: components, matchingPolicy: .nextTime) { date, _, stop in
            guard let date = date else { return }
            guard date < dateInterval.end else {
                stop = true
                return
            }
            
            dates.append(date)
        }
        
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(for: dateInterval, matching: dateComponents([.hour, .minute, .second], from: dateInterval.start))
    }
}

extension DateFormatter {
    convenience init(dateFormatter: String, calendar: Calendar, dateStyle: DateFormatter.Style = .none) {
        self.init()
        self.locale = Locale(identifier: "zh_CN")
        self.dateStyle = dateStyle
        self.calendar = calendar
        self.dateFormat = dateFormatter
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
