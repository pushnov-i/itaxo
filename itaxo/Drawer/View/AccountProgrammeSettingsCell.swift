//
//  AccountProgrammeSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
import UIKit


class AccountProgrammeSettingsCell {
//    let cityLabel : UILabel = {
//        
//    }
    
    let cityLabel: UILabel = {
        let iconView = UILabel()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    let cityCellTextField: UITextField =
    {
        let cellTextField = UITextField()
        cellTextField.autocapitalizationType = .none
        cellTextField.layer.cornerRadius = 16.0
        cellTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        cellTextField.layer.borderWidth = 1.0
        cellTextField.textContentType = .emailAddress
        cellTextField.layer.masksToBounds = true
        cellTextField.font = .systemFont(ofSize: 16.0, weight: .regular)
        cellTextField.placeholder = "Ваш е-мейл"
        cellTextField.textContentType = .emailAddress
        return cellTextField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        addSubview(iconImageView)
        cityLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
            make.height.equalTo(18)
            make.width.equalTo(41)
            
        }
        
        addSubview(cellTextField)
        cityCellTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
            make.height.equalTo(18)
            make.width.equalTo(41)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsAccountMenuDelegate) {
       
        
        cityCellTextField.placeholder = viewModel.placeholder
        cityLabel.image = UIImage(named:viewModel.image!)
        
        
    }
}
