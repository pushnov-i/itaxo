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
        stack.spacing = 20.0
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
          //  make.centerY.equalToSuperview()
//            make.left.equalTo(12)
//            make.height.equalTo(18)
//            make.width.equalTo(41)
//            make.top.equalToSuperview()
//
        }
        
//        addSubview(cityTextLabel)
//        cityTextLabel.snp.makeConstraints { make in
//           // make.centerY.equalToSuperview()
//            make.left.equalTo(12)
//            make.height.equalTo(18)
//            make.width.equalTo(41)
//           // make.top.e
//        }
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
        stack.spacing = 20.0
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
//            make.centerY.equalToSuperview()
//            make.left.equalTo(12)
//            make.height.equalTo(18)
//            make.width.equalTo(41)

        }
//
//        addSubview(languageTextLabel)
//        languageTextLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.left.equalTo(12)
//            make.height.equalTo(18)
//            make.width.equalTo(41)
//        }
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

