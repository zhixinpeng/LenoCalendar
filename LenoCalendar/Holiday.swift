//
//  Holiday.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/6.
//

import Foundation

struct Holiday {
    static let holiday: [String] = [
        "2022-12-31",
        "2023-1-1",
        "2023-1-2",
        "2023-1-21",
        "2023-1-22",
        "2023-1-23",
        "2023-1-24",
        "2023-1-25",
        "2023-1-26",
        "2023-1-27",
        "2023-4-5",
        "2023-4-29",
        "2023-4-30",
        "2023-5-1",
        "2023-5-2",
        "2023-5-3",
        "2023-6-22",
        "2023-6-23",
        "2023-6-24",
        "2023-9-29",
        "2023-9-30",
        "2023-10-1",
        "2023-10-2",
        "2023-10-3",
        "2023-10-4",
        "2023-10-5",
        "2023-10-6"
    ]
    
    static let workHoliday: [String] = [
        "2023-1-28",
        "2023-1-29",
        "2023-4-23",
        "2023-5-6",
        "2023-6-25",
        "2023-10-7",
        "2023-10-8"
    ]
    
    static func isHoliday(date: Date) -> Bool {
        let day =  DateFormatter(calendar: Calendar(identifier: .gregorian), dateFormatter: "YYYY-M-d").string(from: date)
        return holiday.contains(day)
    }
    
    static func isWorkHoliday(date: Date) -> Bool {
        let day =  DateFormatter(calendar: Calendar(identifier: .gregorian), dateFormatter: "YYYY-M-d").string(from: date)
        return workHoliday.contains(day)
    }
}
