//
//  NumberStackView.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit

final class NumberStackView: UIStackView {
    
    private let firstTitle: String
    private let secondTitle: String
    private let thirdTitle: String

    private lazy var firstButton: NumberButton = {
        let button = NumberButton(title: firstTitle, frame: .zero)

        return button
    }()
    
    private lazy var secondButton: UIButton = {
        let button = NumberButton(title: secondTitle, frame: .zero)

        return button
    }()
    
    private lazy var thirdButton: UIButton = {
        let button = NumberButton(title: thirdTitle, frame: .zero)

        return button
    }()
    
    init(firstTitle: String, secondTitle: String, thirdTitle: String, frame: CGRect) {
        self.firstTitle = firstTitle
        self.secondTitle = secondTitle
        self.thirdTitle = thirdTitle
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        axis = .horizontal
        distribution = .fillEqually
        spacing = 5
        
        addArrangedSubview(firstButton)
        addArrangedSubview(secondButton)
        addArrangedSubview(thirdButton)
    }
}
