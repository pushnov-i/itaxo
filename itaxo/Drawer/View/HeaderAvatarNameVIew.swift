//
//  AvatarVIew.swift
//  itaxo
//
//  Created by Genuine on 30.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

class HeaderViewComponent: UITableViewHeaderFooterView {
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.layer.cornerRadius = 48
        iconView.clipsToBounds = true
        iconView.backgroundColor = .black
        return iconView
    }()
    
    let roundedContainer : UIView = {
        let container = UIView()
        container.clipsToBounds = true
        container.layer.cornerRadius = 48
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
        roundedContainer.addSubview(avatarImageView)
        addSubview(roundedContainer)

        NSLayoutConstraint.activate([
            roundedContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            roundedContainer.leftAnchor.constraint(equalTo: leftAnchor,constant: 12),
            roundedContainer.heightAnchor.constraint(equalToConstant: 80),
            roundedContainer.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        addSubview(userNameLabel)
      
        NSLayoutConstraint.activate([
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor,constant: 12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: MenuOptionRepresentable) {
        userNameLabel.text = viewModel.description
        avatarImageView.image = UIImage(named:viewModel.image)!
        print(viewModel.image)
        print("!")
        userNameLabel.textColor = .black
    }
}

