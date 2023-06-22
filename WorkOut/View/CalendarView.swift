//
//  CalendarView.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/22.
//

import UIKit

protocol CalendarViewDataSource: AnyObject {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, cellDate: CalendarView.CalendarDay?) -> UICollectionViewCell
}

final class CalendarView: UIView {
    
    typealias CalendarDay = (date: Date, isContainedInMonth: Bool)
    
    weak var calendarViewDataSource: CalendarViewDataSource?
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        
        return label
    }()
    
    private let calendarStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let weekDayStackView: WeekdayStackView = {
        let stackView = WeekdayStackView()
        
        return stackView
    }()
    
    private var calendarCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private let startDay: Weekday = .sun
    private var indexPathDictionay: [Date: Set<IndexPath>] = [:]
    private let numberOfItemInCalendar = 12 * 10 * 42
    private lazy var todayIndexPath = IndexPath(item: numberOfItemInCalendar / 2, section: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureCollectionView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        addSubview(monthLabel)
        addSubview(calendarStackView)
        calendarStackView.addArrangedSubview(weekDayStackView)
        calendarStackView.addArrangedSubview(calendarCollectionView)
        
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        calendarStackView.translatesAutoresizingMaskIntoConstraints = false
       
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: topAnchor),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            calendarStackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 50),
            calendarStackView.leadingAnchor.constraint(equalTo: monthLabel.leadingAnchor),
            calendarStackView.trailingAnchor.constraint(equalTo: monthLabel.trailingAnchor),
            calendarStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureCollectionView() {
        calendarCollectionView.dataSource = self
        calendarCollectionView.setCollectionViewLayout(setUpLayout(), animated: false)
    }
    
    private func changeMonthLabel(_ point: CGPoint) {
        let contentSize: CGFloat = calendarCollectionView.contentSize.width
        let page: CGFloat = point.x / contentSize
        
        guard !(page.isNaN || page.isInfinite),
              let date: Date = calculateDate(from: IndexPath(item: (Int(page) * 42) + 15, section: 0))?.date else {
            monthLabel.text = "0000.00"
            return
        }
        
        monthLabel.text = date.year + "." + date.month
    }
    
    private func calculateDate(from indexPath: IndexPath) -> CalendarDay? {
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
            
}

// MARK: UICollectionViewLayout
extension CalendarView {
    private func setUpLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let weekdayGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let weekdayGroup = NSCollectionLayoutGroup.horizontal(layoutSize: weekdayGroupSize, subitem: item, count: 7)
        
        let monthGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let monthGroup = NSCollectionLayoutGroup.vertical(layoutSize: monthGroupSize, subitem: weekdayGroup, count: 6)
        
        let section = NSCollectionLayoutSection(group: monthGroup)
        section.orthogonalScrollingBehavior = .paging
        section.visibleItemsInvalidationHandler = { [weak self] _, point, _ in
            self?.changeMonthLabel(point)
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

// MARK: UICollectionVIewDataSource
extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfItemInCalendar
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dataSource = calendarViewDataSource else { return UICollectionViewCell() }
        
        return dataSource.collectionView(collectionView, cellForItemAt: indexPath, cellDate: calculateDate(from: indexPath))
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
}

// MARK: Internal method
extension CalendarView {
    func register(_ cell: AnyClass, identifier: String) {
        calendarCollectionView.register(cell, forCellWithReuseIdentifier: identifier)
    }
    
    func scrollToItem() {
        calendarCollectionView.scrollToItem(at: todayIndexPath, at: .bottom, animated: false)
    }
}
