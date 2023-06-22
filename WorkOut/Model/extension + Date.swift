//
//  extension + Date.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/22.
//

import Foundation

extension Date {
    var weekday: Int {
        get {
            Calendar.current.component(.weekday, from: self)
        }
    }
    
    var firstDayOfTheMonth: Date? {
        get {
            Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self))
        }
    }
    
    var year: String {
        get {
            String(Calendar.current.component(.year, from: self))
        }
    }
    
    var month: String {
        get {
            String(Calendar.current.component(.month, from: self))
        }
    }
    
    var day: String {
        get {
            String(Calendar.current.component(.day, from: self))
        }
    }
    
    func month(from date: Date) -> Int? {
        Calendar.current.dateComponents([.month], from: date, to: self).month
    }
    
    func month(by offset: Int) -> Date? {
        var calendar: Calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        return Calendar.current.date(byAdding: .month, value: offset, to: calendar.startOfDay(for: self))
    }
    
    func day(by offset: Int) -> Date? {
        Calendar.current.date(byAdding: .day, value: offset, to: Calendar.current.startOfDay(for: self))
    }
}
