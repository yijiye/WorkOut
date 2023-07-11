//
//  PopupViewController.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/07/04.
//

import UIKit

final class PopupViewController: UIViewController {
    
    private let viewModel: PopupViewModel
    
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        return view
    }()
    
    private let descriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        
        return stackView
    }()
    
    private lazy var partLabel: UILabel = {
        let label = UILabel()
        let text = "오늘의 운동: \(viewModel.workoutPart) "
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .black
        
        return label
    }()
    
    private let selectEmojiLabel: UILabel = {
        let label = UILabel()
        let text = "오늘의 운동은 어땠나요?"
        label.text = text
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .black
        
        return label
    }()
    
    private let emojiStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let emojiLevel1Button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("😢", for: .normal)

        return button
    }()
    
    private let emojiLevel2Button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("😞", for: .normal)
        
        return button
    }()
    
    private let emojiLevel3Button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("🙂", for: .normal)
        
        return button
    }()
    
    private let emojiLevel4Button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("😆", for: .normal)
        
        return button
    }()
    
    private let emojiLevel5Button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 30)
        button.setTitle("😎", for: .normal)
        
        return button
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.cornerRadius = 5
        textView.clipsToBounds = true
        textView.text = "운동을 기록해주세요"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        
        return textView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        let title = "저장"
        button.setTitle(title, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        
        return button
    }()
    
    init(popupViewModel: PopupViewModel) {
        self.viewModel = popupViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryLabel
        textView.delegate = self
        
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(mainView)
        mainView.addSubview(descriptionStackView)
        descriptionStackView.addArrangedSubview(partLabel)
        descriptionStackView.addArrangedSubview(selectEmojiLabel)
        descriptionStackView.addArrangedSubview(emojiStackView)
        emojiStackView.addArrangedSubview(emojiLevel1Button)
        emojiStackView.addArrangedSubview(emojiLevel2Button)
        emojiStackView.addArrangedSubview(emojiLevel3Button)
        emojiStackView.addArrangedSubview(emojiLevel4Button)
        emojiStackView.addArrangedSubview(emojiLevel5Button)
        mainView.addSubview(textView)
        mainView.addSubview(saveButton)
        
        let safeArea = view.safeAreaLayoutGuide
        let width: CGFloat = 0.8
        let height: CGFloat = 1.5
        let top: CGFloat = 20
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            mainView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: width),
            mainView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: height),
            
            descriptionStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: top),
            descriptionStackView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            textView.topAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: top),
            textView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            textView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: width),
            
            saveButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: top),
            saveButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: top * -1)
            ])
    }
}

extension PopupViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "운동을 기록해주세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
