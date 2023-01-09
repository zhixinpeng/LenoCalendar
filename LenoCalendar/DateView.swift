//
//  DateView.swift
//  LenoCalendar
//
//  Created by Angus on 2023/1/6.
//

import SwiftUI

struct DateView: View {
    private let date: Date
    private let calendar: Calendar
    private let formatter: DateFormatter
    @Binding private var selectedDate: Date
    @State private var isHovered = false
    
    init(date: Date, calendar: Calendar, formatter: DateFormatter, selectedDate: Binding<Date>) {
        self.date = date
        self.calendar = calendar
        self.formatter = formatter
        self._selectedDate = selectedDate
    }
    
    var body: some View {
        let chineseDate = date.getChineseDate()
        let isFestival = chineseDate.festival != nil
        
        return  Button {
            selectedDate = date
        } label: {
            VStack {
                Text(formatter.string(from: date))
                    .font(.custom("AvenirNext-DemiBold", size: 18))
                    .foregroundColor(calendar.isDateInWeekend(date) && !date.isWorkHoliday ? Color("red") : Color("primaryText"))
                
                if(isFestival) {
                    Text(chineseDate.festival!)
                        .font(.system(size: 10))
                        .foregroundColor(Color("red"))
                } else {
                    Text(chineseDate.lunar)
                        .font(.system(size: 10))
                        .foregroundColor(Color("primaryText"))
                }
            }
            .frame(width: 46, height: 46)
        }
        .buttonStyle(.plain)
        .if(date.isHoliday) { view in
            view.background(Color("red").opacity(0.3)).cornerRadius(8)
                .overlay(alignment: .topLeading) {
                    Text("休")
                        .font(.system(size: 8))
                        .foregroundColor(Color("red"))
                        .padding(4)
                }
        }
        .if(date.isWorkHoliday) {view in
            view.background(Color("secondary").opacity(0.3)).cornerRadius(8)
                .overlay(alignment: .topLeading) {
                    Text("班")
                        .font(.system(size: 8))
                        .foregroundColor(Color("primaryText"))
                        .padding(4)
                }
        }
        .if(date.isInSameDay(as: selectedDate) || isHovered) { view in
            view.overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("secondary"), lineWidth: 1)
            }
        }
        .if(date.isInToday) { view in
            view.overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("blue"), lineWidth: 1)
            }
        }
        .onHover { isHovered in
            self.isHovered = isHovered
        }
    }
}
