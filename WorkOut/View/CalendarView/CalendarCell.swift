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
    
    private let emojiView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
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
        stackView.addArrangedSubview(emojiView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            emojiView.widthAnchor.constraint(equalTo: emojiView.heightAnchor, multiplier: 1)
        ])
        
    }
    
    func updateUI(by date: Date, isContainedInMonth: Bool) {
        dateLabel.text = date.day
        dateLabel.textColor = isContainedInMonth ? .black : .gray
        contentView.backgroundColor = .white
    }
}
