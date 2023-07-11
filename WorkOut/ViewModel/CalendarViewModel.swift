//
//  CalendarViewModel.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import Foundation
import Combine

final class CalendarViewModel {
    
    typealias CalendarDay = (date: Date, isContainedInMonth: Bool)
    
    private let networkManager = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    let monthSubject = PassthroughSubject<Date, Never>()
    let imageDataSubject = PassthroughSubject<Data, Never>()

    let totalCalendarItems = 12 * 10 * 42
    private var indexPathDictionay: [Date: Set<IndexPath>] = [:]
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
    
    func fetchWeatherAPI(latitude: Double, longitude: Double) {
        let latitude = String(describing: latitude)
        let longitude = String(describing: longitude)
        let weatherEndpoint = WeatherEndpoint.weatherInformation(latitude: latitude, longitude: longitude)
        
        networkManager.fetchJSON(weatherEndpoint as WeatherEndpoint)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("oops got an JSON error \(error.localizedDescription)")
                case .finished:
                    print("JSON Request completed successfully")
                }
            } receiveValue: { [weak self] (result: WeatherInformation) in
                self?.fetchImage(result.weather[0].icon)
            }
            .store(in: &cancellables)
    }
    
    func fetchImage(_ icon: String) {
        let weatherEndpoint = WeatherEndpoint.weatherIcon(icon: icon)
        
        networkManager.fetchImage(weatherEndpoint)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("oops got an Image error \(error.localizedDescription)")
                case .finished:
                    print("Image Request completed successfully")
                }
            } receiveValue: { [weak self] result in
                self?.imageDataSubject.send(result)
            }
            .store(in: &cancellables)
    }
}
