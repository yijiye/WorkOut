//
//  PickerViewControlller.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit

final class PickerViewControlller: UIViewController {
    
    private let timerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryLabel
        
        configureUI()
    }

    private func configureUI() {
        view.addSubview(timerView)
         
        let safeArea = view.safeAreaLayoutGuide
        
        timerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            timerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.8),
            timerView.heightAnchor.constraint(equalTo: timerView.widthAnchor, multiplier: 1.5)
        ])
    }

}
