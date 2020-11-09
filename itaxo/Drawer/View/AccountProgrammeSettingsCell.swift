//
//  AccountProgrammeSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
import UIKit


class AccountProgrammeSettingsCell:UITableViewCell {
    
    let cityLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    let cityTextLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
            make.height.equalTo(18)
            make.width.equalTo(41)
            
        }
        
        addSubview(cityTextLabel)
        cityTextLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
            make.height.equalTo(18)
            make.width.equalTo(41)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsProgrammeMenuDelegate) {
        
        let cityHead = viewModel.userCity.keys.description
        cityLabel.text = cityHead
        
        
    }
}
