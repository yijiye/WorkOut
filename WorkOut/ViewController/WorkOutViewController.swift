//
//  WorkoutViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import UIKit

final class WorkoutViewController: UIViewController {
    
    private let workoutViewModel: WorkoutViewModel
    private lazy var workoutCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        
        return collectionView
    }()
    
    init(workoutViewModel: WorkoutViewModel) {
        self.workoutViewModel = workoutViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(workoutCollectionView)

        configureCollectionView()
        configureNavigationBar()
    }

    private func configureCollectionView() {
        workoutCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        workoutCollectionView.dataSource = self
        workoutCollectionView.delegate = self 
        workoutCollectionView.register(CircleButtonCell.self, forCellWithReuseIdentifier: CircleButtonCell.identifier)
        workoutCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.boundarySupplementaryItems = [header]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension WorkoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        workoutViewModel.sortedWorkoutDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleButtonCell.identifier, for: indexPath) as? CircleButtonCell else { return UICollectionViewCell() }
        
        let workout = workoutViewModel.sortedWorkoutDictionary[indexPath.item]
        cell.configureCell(with: workout.key, title: workout.value)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView else {
            return UICollectionReusableView()
        }
        let headerTitle = "오늘은 어떤 운동을 해볼까요?"
        header.prepare(text: headerTitle)
        
        return header
    }
}

extension WorkoutViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pickerViewModel = PickerViewModel()
        let timerViewModel = TimerViewModel(pickerViewModel: pickerViewModel)
        let timerViewController = TimerViewController(timerViewModel: timerViewModel, pickerViewMoel: pickerViewModel)
        self.navigationController?.pushViewController(timerViewController, animated: true)
    }
}
