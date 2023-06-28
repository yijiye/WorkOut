//
//  ProgressViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/28.
//

import UIKit
import Combine

final class ProgressViewController: UIViewController {
    
    private let viewModel: ProgressViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let countdownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 100, weight: .bold)
        label.textColor = .black
        
        return label
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.countDown()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(countdownLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
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
                self?.countdownLabel.isHidden = true
                self?.configureCircleProgress()
            }
            .store(in: &cancellables)
    }
    
    private func configureCircleProgress() {
        let circularProgress = ProgressView(frame: CGRect(x: 10.0, y: 30.0, width: 100.0, height: 100.0))
        circularProgress.progressColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 1.0)
        circularProgress.trackColor = UIColor(red: 52.0/255.0, green: 141.0/255.0, blue: 252.0/255.0, alpha: 0.6)
        circularProgress.tag = 101
        circularProgress.center = self.view.center
        self.view.addSubview(circularProgress)
        
        self.perform(#selector(animateProgress), with: nil, afterDelay: 0.3)
    }
    
    @objc private func animateProgress() {
        guard let circleProgress = view.viewWithTag(101) as? ProgressView else { return }
        circleProgress.setProgressWithAnimation(value: 0.8)
    }
}
