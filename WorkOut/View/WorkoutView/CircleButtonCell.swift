//
//  CircleButtonCell.swift
//  WorkOut
//
//  Created by jiye Yi(리지) on 2023/06/26.
//

import UIKit

final class CircleButtonCell: UICollectionViewCell {
    static let identifier = "CircelButtonCell"
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen.withAlphaComponent(0.2)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
 
    override func layoutSubviews() {
        super.layoutSubviews()
        button.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(button)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(button)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.widthAnchor.constraint(equalTo: button.heightAnchor),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}

extension CircleButtonCell {
    func configureCell(with systemImage: String, title: String) {
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        let image = UIImage(systemName: systemImage, withConfiguration: imageConfiguration)
        button.setImage(image, for: .normal)
        button.setTitle(title, for: .normal)
    }
}
