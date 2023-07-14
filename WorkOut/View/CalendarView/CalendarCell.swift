//
//  CalendarCell.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/22.
//

import UIKit

final class CalendarCell: UICollectionViewCell {
    static let identifier = "CalendarCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    private let emojiLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(stackView)
        backgroundColor = .white
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(emojiLabel)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func updateUI(by date: Date, isContainedInMonth: Bool, emoji: String?) {
        dateLabel.text = date.day
        dateLabel.textColor = isContainedInMonth ? .black : .gray
        
        if emoji == nil {
            emojiLabel.text = ""
        } else {
            emojiLabel.text = emoji
        }
        
        contentView.backgroundColor = .white
    }
}
