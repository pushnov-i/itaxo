//
//  HeaderSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit

class SettingsHeaderViewComponent: UITableViewHeaderFooterView {
    
    let headerSettingsLabel : UILabel = {
        
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
      
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(headerSettingsLabel)
        
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(80)
            make.width.equalTo(160)
            make.left.equalTo(12)
           // make.leading.equalTo(view.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderTopDelegate) {
        headerSettingsLabel.text = viewModel.topHeader
        print("!")
        headerSettingsLabel.textColor = .black
    }
}
class SettingsAccountHeaderViewComponent: UITableViewHeaderFooterView {
    
    let headerSettingsLabel : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        
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
      
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(headerSettingsLabel)
        
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(80)
            make.width.equalTo(160)
            make.left.equalTo(12)
           // make.leading.equalTo(view.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderAccountDelegate) {
        headerSettingsLabel.text = viewModel.accountSettingsHeader
        print("!")
        headerSettingsLabel.textColor = .black
    }
}

class SettingsProgrammeHeaderViewComponent: UITableViewHeaderFooterView {
    
    let headerSettingsLabel : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .green
        
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
      
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addSubview(headerSettingsLabel)
        
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(80)
            make.width.equalTo(160)
            make.left.equalTo(12)
           // make.leading.equalTo(view.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderProgrammeDelegate) {
        headerSettingsLabel.text = viewModel.programmeSettingsHeader
        print("!")
        headerSettingsLabel.textColor = .black
    }
}
