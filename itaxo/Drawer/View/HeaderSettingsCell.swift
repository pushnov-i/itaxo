//
//  HeaderSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class SettingsTopHeaderViewComponent: UITableViewHeaderFooterView {
    
    
    let headerSettingsLabel : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
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
    
    let button : UIButton = {
        let buttonView = UIButton()
        buttonView.backgroundColor = .clear
        buttonView.layer.cornerRadius = 25
        buttonView.setImage(UIImage(named: "cancel icon"), for: .normal)
        return buttonView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(headerSettingsLabel)
        
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(250)
            //       make.top.equalTo(button.snp.bottom).offset(15)
            //            make.leading.equalTo(contentView.snp.left).offset(20)
            make.left.equalToSuperview().offset(12)
            make.centerY.equalToSuperview().offset(25)
        }
        addSubview(button)
        button.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderTopDelegate) {
        headerSettingsLabel.text = viewModel.topHeader
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
        guard let customFont = UIFont(name: "Roboto-Regular", size: 15) else {
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
        headerSettingsLabel.addViewBackedBorder(side: .bottom, thickness: 1, color: borderColor!)
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(325)
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
        headerSettingsLabel.textColor = .black
        contentView.backgroundColor = .white
    }
    
}

class SettingsProgrammeHeaderViewComponent: UITableViewHeaderFooterView {
    
    let headerSettingsLabel : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let font = UIFont(name: "Roboto",size: 17)
        guard let customFont = UIFont(name: "Roboto-Regular", size: 15) else {
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
        headerSettingsLabel.addViewBackedBorder(side: .bottom, thickness: 0.5, color: borderColor!)
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(325)
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderProgrammeDelegate) {
        headerSettingsLabel.text = viewModel.programmeSettingsHeader
        headerSettingsLabel.textColor = .black
        contentView.backgroundColor = .white
    }
}

