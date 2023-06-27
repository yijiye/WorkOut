//
//  TimerStackView.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit

final class TimerStackView: UIStackView {
    
    weak var delegate: TapGestureReconizable?
    
    private let workoutStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let restStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let workoutSetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private let workoutTimeLabel: UILabel = {
        let label = UILabel()
        let title = "운동시간"
        label.text = title
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .black
        
        return label
    }()
    
    private let restLabel: UILabel = {
        let label = UILabel()
        let title = "휴식시간"
        label.text = title
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .black
        
        return label
    }()
    
    private let workoutSetLabel: UILabel = {
        let label = UILabel()
        let title = "세트 수"
        label.text = title
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .black
        
        return label
    }()
    
    private let workoutTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let restTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    private let workoutSetCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .systemBlue
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureSubStackViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 30
        addArrangedSubview(workoutStackView)
        addArrangedSubview(restStackView)
        addArrangedSubview(workoutSetStackView)
        
        let workoutTimerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(workoutTimerButtonTapped))
        let restTimerTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(restTimerButtonTapped))
        let workoutSetCountTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(setCountButtonTapped))
       
        workoutTimerLabel.addGestureRecognizer(workoutTimerTapGestureRecognizer)
        restTimerLabel.addGestureRecognizer(restTimerTapGestureRecognizer)
        workoutSetCountLabel.addGestureRecognizer(workoutSetCountTapGestureRecognizer)
    }
    
    private func configureSubStackViews() {
        workoutStackView.addArrangedSubview(workoutTimeLabel)
        workoutStackView.addArrangedSubview(workoutTimerLabel)
        
        restStackView.addArrangedSubview(restLabel)
        restStackView.addArrangedSubview(restTimerLabel)
        
        workoutSetStackView.addArrangedSubview(workoutSetLabel)
        workoutSetStackView.addArrangedSubview(workoutSetCountLabel)

        workoutTimeLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        workoutTimerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        restLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        restTimerLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        workoutSetLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        workoutSetCountLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
    }
    
    @objc private func workoutTimerButtonTapped(_ sender: UITapGestureRecognizer) {
        delegate?.timerButtonTapped(.workout)
    }
    
    @objc private func restTimerButtonTapped(_ sender: UITapGestureRecognizer) {
        delegate?.timerButtonTapped(.rest)
    }
    
    @objc private func setCountButtonTapped(_ sender: UITapGestureRecognizer) {
        delegate?.timerButtonTapped(.setCount)
    }
}

extension TimerStackView {
    func setUpWorkoutTimerLabel(_ text: String) {
        workoutTimerLabel.text = text
    }
    
    func setUpRestTimerLabel(_ text: String) {
        restTimerLabel.text = text
    }
    
    func setUpSetCountLabel(_ text: String) {
        workoutSetCountLabel.text = text
    }
}
