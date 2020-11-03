//
//  MenuOptionCell.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Sample text"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 12),
        iconImageView.heightAnchor.constraint(equalToConstant: 24),
        iconImageView.widthAnchor.constraint(equalToConstant: 24)
            ])
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor,constant: 12)
          ])
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func configure(withViewModel viewModel: MenuOptionRepresentable) {
        switch viewModel.state {
        case true : descriptionLabel.textColor = .black
        case false : descriptionLabel.textColor = UIColor(hex: "#939393ff")
        }
        
        descriptionLabel.text = viewModel.description
        iconImageView.image = UIImage(named:viewModel.image)
        
    }
}

