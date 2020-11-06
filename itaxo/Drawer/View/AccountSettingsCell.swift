//
//  AccountSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

class AccountSettingsCell: UITableViewCell {
    
    let iconImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    let emailTextField: UITextField =
    {
        let emailTextField = UITextField()
        emailTextField.autocapitalizationType = .none
        emailTextField.layer.cornerRadius = 16.0
        emailTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.textContentType = .emailAddress
        emailTextField.layer.masksToBounds = true
        emailTextField.font = .systemFont(ofSize: 16.0, weight: .regular)
        emailTextField.placeholder = "Ваш е-мейл"
        emailTextField.textContentType = .emailAddress
        return emailTextField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
            make.height.equalTo(24)
            make.width.equalTo(24)
            
        }
        
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsAccountMenuDelegate) {
       
        
        emailTextField.placeholder = viewModel.placeholder
        iconImageView.image = UIImage(named:viewModel.image!)
        
        
    }
}

