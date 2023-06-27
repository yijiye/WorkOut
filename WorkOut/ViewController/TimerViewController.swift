//
//  TimerViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import UIKit

final class TimerViewController: UIViewController {
    
    private let timerStackView: TimerStackView = {
        let stackView = TimerStackView()
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureUI()
        configureNavigationBar()
    }
    
    private func configureUI() {
        view.addSubview(timerStackView)
        
        let safeArea = view.safeAreaLayoutGuide
        let top: CGFloat = 20
        let leading: CGFloat = 30
        let trailing: CGFloat = -30
        
        timerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: leading),
            timerStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: trailing),
            timerStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: top)
        ])
    }

    private func configureNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
    }
}
