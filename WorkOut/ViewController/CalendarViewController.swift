//
//  CalendarViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/21.
//

import UIKit

final class CalendarViewController: UIViewController {
    
    private let calendarViewModel: CalendarViewModel
    
    private lazy var calendarView: CalendarView = {
        let calendarView = CalendarView(viewModel: calendarViewModel, frame: .zero)
        calendarView.backgroundColor = .white
        calendarView.register(CalendarCell.self, identifier: CalendarCell.identifier)
        
        return calendarView
    }()
    
    init(calendarViewModel: CalendarViewModel) {
        self.calendarViewModel = calendarViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigationBar()
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
    
    private func configureNavigationBar() {
        let title = "운동시작"
        let goToWorkOutButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(goToWorkOutButtonTapped))
        
        navigationItem.rightBarButtonItem = goToWorkOutButton
    }
    
    @objc private func goToWorkOutButtonTapped() {
        let workoutViewModel = WorkoutViewModel()
        let workOutViewController = WorkoutViewController(workoutViewModel: workoutViewModel)
        self.navigationController?.pushViewController(workOutViewController, animated: true)
    }
}

extension CalendarViewController: CalendarViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, cellDate: CalendarViewModel.CalendarDay?) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CalendarCell.identifier, for: indexPath) as? CalendarCell,
              let cellDate = cellDate else { return UICollectionViewCell() }
        
        cell.updateUI(by: cellDate.date, isContainedInMonth: cellDate.isContainedInMonth)
        
        return cell
    }
}
