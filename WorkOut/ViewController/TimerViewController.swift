//
//  TimerViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import UIKit

final class TimerViewController: UIViewController {
    
    private let pickerViewMoel: PickerViewModel
    
    private let timerStackView: TimerStackView = {
        let stackView = TimerStackView()
        
        return stackView
    }()
    
    init(pickerViewMoel: PickerViewModel) {
        self.pickerViewMoel = pickerViewMoel
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
    }
    
    private func configureUI() {
        timerStackView.delegate = self
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

extension TimerViewController: TapGestureReconizable {
    func timerButtonTapped() {
        let pickerViewController = PickerViewControlller(viewModel: pickerViewMoel)
        pickerViewController.modalPresentationStyle = .overFullScreen
        present(pickerViewController, animated: true)
    }
}
