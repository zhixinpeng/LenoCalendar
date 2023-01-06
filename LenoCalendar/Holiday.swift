//
//  Holiday.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/6.
//

import Foundation

struct Holiday {
    static let holiday: [String: String] = [
        "2023-1-1": "元旦",
        "2023-2-4": "立春",
        "2023-2-14": "情人节",
        "2023-2-19": "雨水",
        "2023-3-6": "惊蛰",
        "2023-3-8": "妇女节",
        "2023-3-12": "植树节",
        "2023-3-21": "春分",
        "2023-4-5": "清明",
        "2023-4-20": "谷雨",
        "2023-5-1": "劳动节",
        "2023-5-4": "青年节",
        "2023-5-6": "立夏",
        "2023-6-1": "儿童节",
        "2023-7-1": "建党节",
        "2023-8-1": "建军节",
        "2023-10-1": "国庆",
        "2023-12-25": "圣诞节",
    ]
    
    static func getHoliday(date: Date) -> String? {
        let formatterDate = DateFormatter(dateFormatter: "YYYY-M-d", calendar: Calendar(identifier: .gregorian)).string(from: date)
        
        print(formatterDate)
        
        if let holiday = holiday[formatterDate] {
            return holiday
        }
        
        return nil
    }
}
