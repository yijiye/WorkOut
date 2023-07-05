//
//  ProgressViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/28.
//

import UIKit
import Combine
import AudioToolbox

final class ProgressViewController: UIViewController {
    
    enum PlayMode {
        case pause
        case resume
    }
    
    private let viewModel: ProgressViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private var playMode: PlayMode = .pause
    
    private let countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        stackView.isHidden = true
        
        return stackView
    }()
    
    private let countTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.text = "남은 세트 :"
        
        return label
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.textColor = .black
        label.isHidden = true
        
        return label
    }()
    
    private let countdownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 100
        stackView.isHidden = true
        
        return stackView
    }()
    
    private let pauseButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let buttonImage = UIImage(systemName: "pause.fill", withConfiguration: configuration)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        let title = "종료"
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        
        return button
    }()
    
    init(viewModel: ProgressViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bind()
        addButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.countDown()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(countStackView)
        countStackView.addArrangedSubview(countTitleLabel)
        countStackView.addArrangedSubview(countLabel)
        
        view.addSubview(timerLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(pauseButton)
        buttonStackView.addArrangedSubview(stopButton)
        
        view.addSubview(countdownLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        let top: CGFloat = 50
        let buttonTop: CGFloat = -200
        
        countStackView.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: top),
            countStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            timerLabel.topAnchor.constraint(equalTo: countStackView.bottomAnchor, constant: top),
            timerLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            buttonStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: buttonTop),
            buttonStackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            countdownLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            countdownLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
    private func bind() {
        viewModel.countdownLabel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] countdown in
                self?.countdownLabel.text = countdown
            }
            .store(in: &cancellables)
        
        viewModel.countdownComplete
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.checkUIHidden()
                self?.viewModel.start()
            }
            .store(in: &cancellables)
        
        viewModel.$workoutTimerLabel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.timerLabel.text = $0
            }
            .store(in: &cancellables)
        
        viewModel.$setCount
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.countLabel.text = $0
            }
            .store(in: &cancellables)
        
        viewModel.isFinished
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.bindTimerLabel()
                AudioServicesPlaySystemSound(1304)
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
            .store(in: &cancellables)
    }
    
    private func bindTimerLabel() {
        viewModel.$workoutTimerLabel
            .combineLatest(viewModel.$restTimerLabel, viewModel.$timerType)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] workoutTimerLabel, restTimerLabel, timerType in
                switch timerType {
                case .workout:
                    self?.timerLabel.textColor = .black
                    self?.timerLabel.text = workoutTimerLabel
                case .rest:
                    self?.timerLabel.textColor = .systemGreen
                    self?.timerLabel.text = restTimerLabel
                case .setCount:
                    return
                }
            }
            .store(in: &cancellables)
    }
    
    private func checkUIHidden() {
        countdownLabel.isHidden = true
        timerLabel.isHidden = false
        countStackView.isHidden = false
        buttonStackView.isHidden = false
    }
    
    private func addButtonAction() {
        pauseButton.addTarget(self, action: #selector(pauseButtonTapped), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopButtonTapped), for: .touchUpInside)
    }
}

extension ProgressViewController {
    @objc private func pauseButtonTapped() {
        switch playMode {
        case .pause:
            let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
            let buttonImage = UIImage(systemName: "play.fill", withConfiguration: configuration)
            pauseButton.setImage(buttonImage, for: .normal)
            viewModel.pause()
            playMode = .resume
        case .resume:
            let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
            let buttonImage = UIImage(systemName: "pause.fill", withConfiguration: configuration)
            pauseButton.setImage(buttonImage, for: .normal)
            viewModel.resume()
            playMode = .pause
        }
    }
    
    @objc private func stopButtonTapped() {
        viewModel.stop()
        let popupViewModel = PopupViewModel(workoutPart: viewModel.workoutPart)
        let popupViewController = PopupViewController(popupViewModel: popupViewModel)
        popupViewController.modalPresentationStyle = .overFullScreen
        present(popupViewController, animated: true)
    }
}
