//
//  CalendarViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import Foundation
import Combine

final class CalendarViewModel {
    var dateSubject = PassthroughSubject<Date, Never>()
    
    typealias CalendarDay = (date: Date, isContainedInMonth: Bool)
    
    private var indexPathDictionay: [Date: Set<IndexPath>] = [:]
    let numberOfItemInCalendar = 12 * 10 * 42
    lazy var todayIndexPath = IndexPath(item: numberOfItemInCalendar / 2, section: 0)
    
    func calculateDate(from indexPath: IndexPath) -> CalendarDay? {
        let numberOfCellPerPage: Int = 42
        let todayPage = todayIndexPath.item / numberOfCellPerPage
        let indexPage = indexPath.item / numberOfCellPerPage
        
        guard let today = Date().firstDayOfTheMonth,
              let indexPathDate = today.month(by: indexPage - todayPage) else { return nil }
        
        var indexPathPageFirstDayWeekday = indexPathDate.weekday - 1
        indexPathPageFirstDayWeekday = indexPathPageFirstDayWeekday < 0 ? 6 : indexPathPageFirstDayWeekday
        let dist: Int = indexPath.item % numberOfCellPerPage
        var isContainedInMonth: Bool = false
        
        guard let date: Date = indexPathDate.day(by: dist - indexPathPageFirstDayWeekday),
              let monthDist = date.firstDayOfTheMonth?.month(from: indexPathDate) else { return nil }
        indexPathDictionay[date, default: []].insert(indexPath)
        if monthDist == 0 {
            isContainedInMonth = true
        }
        return CalendarDay(date: date, isContainedInMonth: isContainedInMonth)
    }
    
    func changeMonthLabel(_ page: CGFloat) {
        guard !(page.isNaN || page.isInfinite),
              let date: Date = calculateDate(from: IndexPath(item: (Int(page) * 42) + 15, section: 0))?.date else { return }
        
        dateSubject.send(date)
    }
}
