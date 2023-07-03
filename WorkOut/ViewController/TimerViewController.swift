//
//  TimerViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import UIKit
import Combine

final class TimerViewController: UIViewController {
    
    private let timerViewModel: TimerViewModel
    private let pickerViewModel: PickerViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    private let timerStackView: TimerStackView = {
        let stackView = TimerStackView()
        
        return stackView
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let image = UIImage(systemName: "play.fill", withConfiguration: imageConfiguration)
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    init(timerViewModel: TimerViewModel, pickerViewMoel: PickerViewModel) {
        self.timerViewModel = timerViewModel
        self.pickerViewModel = pickerViewMoel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureUI()
        configureNavigationBar()
        configureButton()
        bind()
    }
    
    private func configureUI() {
        timerStackView.delegate = self
        view.addSubview(timerStackView)
        view.addSubview(startButton)
        
        let safeArea = view.safeAreaLayoutGuide
        let top: CGFloat = 20
        let leading: CGFloat = 30
        let trailing: CGFloat = -30
        
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: leading),
            timerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: trailing),
            timerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: top),
            
            startButton.topAnchor.constraint(equalTo: timerStackView.bottomAnchor, constant: top),
            startButton.leadingAnchor.constraint(equalTo: timerStackView.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: timerStackView.trailingAnchor)
        ])
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    private func configureButton() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        timerViewModel.$workoutTimerLabel
            .sink { [weak self] label in
                self?.timerStackView.setUpWorkoutTimerLabel(label)
            }
            .store(in: &cancellables)
        timerViewModel.$restTimerLabel
            .sink { [weak self] label in
                self?.timerStackView.setUpRestTimerLabel(label)
            }
            .store(in: &cancellables)
        timerViewModel.$setCountLabel
            .sink { [weak self] label in
                self?.timerStackView.setUpSetCountLabel(label)
            }
            .store(in: &cancellables)
        
    }
    
    @objc private func startButtonTapped() {
        let progressViewModel = ProgressViewModel(timerViewModel: timerViewModel)
        let progressViewController = ProgressViewController(viewModel: progressViewModel)
        progressViewController.modalPresentationStyle = .fullScreen
        present(progressViewController, animated: true)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

extension TimerViewController: TapGestureReconizable {
    func timerButtonTapped(_ type: TimerType) {
        let pickerViewController = PickerViewControlller(timerType: type, viewModel: pickerViewModel)
        pickerViewController.modalPresentationStyle = .overFullScreen
        present(pickerViewController, animated: true)
    }
}
