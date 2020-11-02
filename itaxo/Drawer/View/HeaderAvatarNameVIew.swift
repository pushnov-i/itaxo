//
//  AvatarVIew.swift
//  itaxo
//
//  Created by Genuine on 30.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit

class HeaderViewComponent: UITableViewHeaderFooterView {
    
    let userNameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        if let font = UIFont(name: "HelveticaNeue",size: 17) {
            label.font = font
        }
       // label.font = UIFont.init(name: "Roboto",size: 17)   ///  Didn't change font type only size try NSAttriButedString
        return label
    }()
    
    let avatarImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.layer.cornerRadius = 48
        //  iconView.clipsToBounds = true
        iconView.backgroundColor = .black
        return iconView
    }()
    
    let roundedContainer : UIView = {
        let container = UIView()
        // container.clipsToBounds = true
        container.layer.cornerRadius = 48
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        roundedContainer.addSubview(avatarImageView)
        addSubview(roundedContainer)
        addSubview(userNameLabel)
        roundedContainer.snp.makeConstraints{(make) -> Void in
            make.width.height.equalTo(80)
            make.left.equalTo(12)
            make.center.equalTo(self)
        }
        avatarImageView.snp.makeConstraints{(make) -> Void in
            make.width.height.equalTo(80)
        }
        userNameLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(80)
            make.width.equalTo(160)
            make.center.equalToSuperview()
            // make.top.equalTo(self.contentView.snp.top)
            //  make.leading.equalTo(avatarImageView).inset(20)
            // make.center.equalTo(contentView)
            // make.left.equalTo
        }
        //        NSLayoutConstraint.activate([
        //            roundedContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
        //            roundedContainer.leftAnchor.constraint(equalTo: leftAnchor,constant: 12),
        //            roundedContainer.heightAnchor.constraint(equalToConstant: 80),
        //            roundedContainer.widthAnchor.constraint(equalToConstant: 80)
        //        ])
        
        
        
        //        NSLayoutConstraint.activate([
        //            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        //            userNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor,constant: 12)
        //        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: MenuOptionRepresentable) {
        userNameLabel.text = viewModel.description
        avatarImageView.image = UIImage(named:viewModel.image)!
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView!.backgroundColor = UIColor(hex: "#FFDE43ff")
        print(viewModel.image)
        print("!")
        userNameLabel.textColor = .black
    }
}

