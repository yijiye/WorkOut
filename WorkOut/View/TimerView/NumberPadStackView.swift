//
//  NumberPadStackView.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/27.
//

import UIKit

final class NumberPadStackView: UIStackView {
    
    private let firstLineStackView: NumberStackView = {
        let stackView = NumberStackView(
            firstTitle: NumberPad.one.description,
            secondTitle: NumberPad.two.description,
            thirdTitle: NumberPad.three.description,
            frame: .zero
        )

        return stackView
    }()
    
    private let secondLineStackView: UIStackView = {
        let stackView = NumberStackView(
            firstTitle: NumberPad.four.description,
            secondTitle: NumberPad.five.description,
            thirdTitle: NumberPad.six.description,
            frame: .zero
        )

        return stackView
    }()
    
    private let thirdLineStackView: UIStackView = {
        let stackView = NumberStackView(
            firstTitle: NumberPad.seven.description,
            secondTitle: NumberPad.eight.description,
            thirdTitle: NumberPad.nine.description,
            frame: .zero
        )

        return stackView
    }()
    
    private let finalLineStackView: UIStackView = {
        let stackView = NumberStackView(
            firstTitle: NumberPad.reset.description,
            secondTitle: NumberPad.zero.description,
            thirdTitle: NumberPad.delete.description,
            frame: .zero
        )

        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
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
}
