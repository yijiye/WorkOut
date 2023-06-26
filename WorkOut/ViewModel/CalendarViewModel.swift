//
//  CalendarViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import Foundation
import Combine

final class CalendarViewModel {
    var monthSubject = PassthroughSubject<Date, Never>()
    
    typealias CalendarDay = (date: Date, isContainedInMonth: Bool)
    
    private var indexPathDictionay: [Date: Set<IndexPath>] = [:]
    let totalCalendarItems = 12 * 10 * 42
    lazy var todayIndexPath = IndexPath(item: totalCalendarItems / 2, section: 0)
    
    func calculateDate(from indexPath: IndexPath) -> CalendarDay? {
        let numberOfCellPerPage = 42
        let todayPage = todayIndexPath.item / numberOfCellPerPage
        let indexPage = indexPath.item / numberOfCellPerPage
        
        guard let today = Date().firstDayOfTheMonth,
              let thisMonth = today.month(by: indexPage - todayPage) else { return nil }
        
        var firstDayOfWeek = thisMonth.weekday - 1
        firstDayOfWeek = firstDayOfWeek < 0 ? 6 : firstDayOfWeek
        let dayDistance = indexPath.item % numberOfCellPerPage
        var isContainedInMonth: Bool = false
        
        guard let date = thisMonth.day(by: dayDistance - firstDayOfWeek),
              let monthDistance = date.firstDayOfTheMonth?.month(from: thisMonth) else { return nil }
        
        indexPathDictionay[date, default: []].insert(indexPath)
        if monthDistance == 0 { isContainedInMonth = true }
        
        return CalendarDay(date: date, isContainedInMonth: isContainedInMonth)
    }
    
    func updateMonth(_ page: CGFloat) {
        guard !(page.isNaN || page.isInfinite),
              let month: Date = calculateDate(from: IndexPath(item: (Int(page) * 42) + 15, section: 0))?.date else { return }
        
        monthSubject.send(month)
    }
}
