//
//  AccountProgrammeSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
import UIKit


class AccountProgrammeCitySettingsCell:UITableViewCell {
    
    let cityLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    var cityTextLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFit
        [self.cityLabel,
         self.cityTextLabel,
            ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.leading.equalToSuperview().offset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsProgrammeMenuDelegate) {
        
        let city = viewModel.userCity["city"]
        cityLabel.text = city
        cityLabel.textColor = UIColor(hex: "#939393ff")
        let cityText = viewModel.userCity["cityText"]
        cityTextLabel.text = cityText
        cityTextLabel.textColor = .black
        
        
    }
}

class AccountProgrammeLanguageSettingsCell: UITableViewCell {
    
    let languageLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    var languageTextLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5.0
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFit
        [self.languageLabel,
         self.languageTextLabel,
            ].forEach { stack.addArrangedSubview($0) }
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.left.leading.equalToSuperview().offset(12)
            //make.left.equalTo(12)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsProgrammeMenuDelegate) {
        
        
        let language = viewModel.userLanguage["language"]
        languageLabel.text = language
        languageLabel.textColor = UIColor(hex: "#939393ff")
        let languageText = viewModel.userLanguage["languageText"]
        languageTextLabel.text = languageText
        languageTextLabel.textColor = .black
        
    }
}

