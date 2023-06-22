//
//  WeekdayView.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/22.
//

import UIKit

final class WeekdayStackView: UIStackView {
    private var weekday: [Weekday] = Weekday.allCases.map { $0 }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        axis = .horizontal
        distribution = .fillEqually
        
        weekday.forEach {
            let label: UILabel = UILabel()
            label.textAlignment = .center
            label.textColor = .black
            
            if $0 == .sun {
                label.textColor = .red
            }
            
            label.text = $0.description
            addArrangedSubview(label)
        }
    }
}
