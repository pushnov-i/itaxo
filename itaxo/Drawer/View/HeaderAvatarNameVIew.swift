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
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.layer.cornerRadius = 80
        iconView.clipsToBounds = true
        iconView.backgroundColor = .white
        return iconView
    }()
    
//    let roundedContainer : UIView = {
//        let container = UIView()
//        container.clipsToBounds = true
//        container.layer.cornerRadius = 48
//        container.translatesAutoresizingMaskIntoConstraints = false
//        return container
//    }()
    
    override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
        addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 12),
            avatarImageView.heightAnchor.constraint(equalToConstant: 24),
            avatarImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.numberOfLines = 0
        
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
        avatarImageView.image = UIImage(named:viewModel.image)
        print(viewModel.image)
        print("!")
        userNameLabel.textColor = .black
    }
}

