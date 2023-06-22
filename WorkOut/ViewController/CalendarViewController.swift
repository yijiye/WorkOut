//
//  CalendarViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/21.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    private let calendarView: CalendarView = {
        let calendarView = CalendarView()
        calendarView.backgroundColor = .white
        calendarView.register(CalendarCell.self, identifier: CalendarCell.identifier)
        
        return calendarView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calendarView.scrollToItem()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(calendarView)
        calendarView.calendarViewDataSource = self
        
        let safeArea = view.safeAreaLayoutGuide
        let leading: CGFloat = 10
        let trailing: CGFloat = -10
        let top: CGFloat = 20
        let bottom: CGFloat = -50
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: leading),
            calendarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: trailing),
            calendarView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: top),
            calendarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: bottom)
        ])
    }
}

extension CalendarViewController: CalendarViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, cellDate: CalendarView.CalendarDay?) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell,
              let cellDate = cellDate else { return UICollectionViewCell() }
        
        cell.updateUI(by: cellDate.date, isContainedInMonth: cellDate.isContainedInMonth)
        
        return cell
    }
}
