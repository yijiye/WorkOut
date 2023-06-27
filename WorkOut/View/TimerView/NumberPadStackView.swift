//
//  NumberPadStackView.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit

final class NumberPadStackView: UIStackView {
    
    private let firstLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let oneButton: NumberButton = {
        let one = "1"
        let button = NumberButton(title: one, frame: .zero)

        return button
    }()
    
    private let twoButton: UIButton = {
        let two = "2"
        let button = NumberButton(title: two, frame: .zero)

        return button
    }()
    
    private let threeButton: UIButton = {
        let three = "3"
        let button = NumberButton(title: three, frame: .zero)

        return button
    }()
    
    private let secondLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let fourButton: UIButton = {
        let four = "4"
        let button = NumberButton(title: four, frame: .zero)

        return button
    }()
    
    private let fiveButton: UIButton = {
        let five = "5"
        let button = NumberButton(title: five, frame: .zero)

        return button
    }()
    
    private let sixButton: UIButton = {
        let six = "6"
        let button = NumberButton(title: six, frame: .zero)

        return button
    }()
    
    private let thirdLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()

    private let sevenButton: UIButton = {
        let seven = "7"
        let button = NumberButton(title: seven, frame: .zero)

        return button
    }()
    
    private let eightButton: UIButton = {
        let eight = "8"
        let button = NumberButton(title: eight, frame: .zero)

        return button
    }()
    
    private let nineButton: UIButton = {
        let nine = "9"
        let button = NumberButton(title: nine, frame: .zero)

        return button
    }()
    
    private let finalLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        return stackView
    }()

    private let resetButton: UIButton = {
        let reset = "C"
        let button = NumberButton(title: reset, frame: .zero)

        return button
    }()
    
    private let zeroButton: UIButton = {
        let zero = "0"
        let button = NumberButton(title: zero, frame: .zero)

        return button
    }()
    
    private let deleteButton: UIButton = {
        let delete = "DEL"
        let button = NumberButton(title: delete, frame: .zero)

        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureSubStackViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        axis = .vertical
        distribution = .fillEqually
        spacing = 5
        
        addArrangedSubview(firstLineStackView)
        addArrangedSubview(secondLineStackView)
        addArrangedSubview(thirdLineStackView)
        addArrangedSubview(finalLineStackView)
    }
    
    private func configureSubStackViews() {
        firstLineStackView.addArrangedSubview(oneButton)
        firstLineStackView.addArrangedSubview(twoButton)
        firstLineStackView.addArrangedSubview(threeButton)
        
        secondLineStackView.addArrangedSubview(fourButton)
        secondLineStackView.addArrangedSubview(fiveButton)
        secondLineStackView.addArrangedSubview(sixButton)
        
        thirdLineStackView.addArrangedSubview(sevenButton)
        thirdLineStackView.addArrangedSubview(eightButton)
        thirdLineStackView.addArrangedSubview(nineButton)
        
        finalLineStackView.addArrangedSubview(resetButton)
        finalLineStackView.addArrangedSubview(zeroButton)
        finalLineStackView.addArrangedSubview(deleteButton)
    }
}
