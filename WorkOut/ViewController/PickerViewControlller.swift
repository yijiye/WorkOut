//
//  PickerViewControlller.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit

final class PickerViewControlller: UIViewController {
    
    private let timerView: UIView = {
        let stackView = UIView()
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 20
        stackView.clipsToBounds = true
        
        return stackView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        let buttonImage = UIImage(systemName: "xmark.square", withConfiguration: configuration)
        button.setImage(buttonImage, for: .normal)
        button.tintColor = .secondaryLabel
        
        return button
    }()
    
    private let pickerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let inputLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.text = "00:00:00"
        
        return label
    }()
    
    private let numberPad: NumberPadStackView = {
        let stackView = NumberPadStackView()
       
        return stackView
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        let title = "OK"
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryLabel
        
        configureUI()
        configureButton()
    }

    private func configureUI() {
        view.addSubview(timerView)
        timerView.addSubview(closeButton)
        timerView.addSubview(pickerStackView)
        pickerStackView.addArrangedSubview(inputLabel)
        pickerStackView.addArrangedSubview(numberPad)
        pickerStackView.addArrangedSubview(okButton)
        
        let safeArea = view.safeAreaLayoutGuide
        let timerViewWidth: CGFloat = 0.8
        let timerViewHeight: CGFloat = 1.3
        let closeButtonVerticalConstant: CGFloat = 20
        let pickerStackViewHorizontalConstant: CGFloat = 15
        let pickerStackViewTop: CGFloat = 10
        let pickerStackViewBottom: CGFloat = -10
        
        timerView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        pickerStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            timerView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            timerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: timerViewWidth),
            timerView.heightAnchor.constraint(equalTo: timerView.widthAnchor, multiplier: timerViewHeight),
            
            closeButton.topAnchor.constraint(equalTo: timerView.topAnchor, constant: closeButtonVerticalConstant),
            closeButton.trailingAnchor.constraint(equalTo: timerView.trailingAnchor, constant: closeButtonVerticalConstant * -1),
            
            pickerStackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: pickerStackViewTop),
            pickerStackView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor, constant: pickerStackViewHorizontalConstant),
            pickerStackView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor, constant: pickerStackViewHorizontalConstant * -1),
            pickerStackView.bottomAnchor.constraint(equalTo: timerView.bottomAnchor, constant: pickerStackViewBottom)
        ])
        
        closeButton.setContentHuggingPriority(.defaultHigh, for: .vertical)
        pickerStackView.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    private func configureButton() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
}

extension PickerViewControlller {
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}
