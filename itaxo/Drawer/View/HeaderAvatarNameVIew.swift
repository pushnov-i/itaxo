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
        
        let font = UIFont(name: "Roboto",size: 17)
        guard let customFont = UIFont(name: "Roboto-Regular", size: 17) else {
            fatalError("""
                Failed to load the "Roboto-Regular" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        
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
        }
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

