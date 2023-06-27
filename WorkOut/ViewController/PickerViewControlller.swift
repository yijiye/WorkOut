//
//  PickerViewControlller.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit
import Combine

final class PickerViewControlller: UIViewController {
    
    private let viewModel: PickerViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
    
    init(viewModel: PickerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryLabel
        
        configureUI()
        configureButton()
        bind() 
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
        numberPad.setUpDelegate(self)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.$inputLabel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] label in
                self?.inputLabel.text = label
            }
            .store(in: &cancellables)
        
        viewModel.$isMeasurable
            .receive(on: DispatchQueue.main)
            .filter { $0 == false }
            .sink { [weak self] _ in
                self?.showAlert()
            }
            .store(in: &cancellables)
    }
    
    private func showAlert() {
        let title = "😰 \n너무 긴 운동시간은 몸에 해로워요! "
        let message = "타이머를 설정할 수 있는 범위를 벗어났습니다."
        let okTitle = "OK"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension PickerViewControlller: NumberButtonDelegate {
    func buttonTapped(_ number: String) {
        viewModel.enterNumber(number)
    }
    
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}
