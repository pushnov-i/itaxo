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
    
    let accountCellTextField: UITextField =
    {
        let cellTextField = UITextField()
        cellTextField.autocapitalizationType = .none
        cellTextField.layer.cornerRadius = 16.0
       // cellTextField.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
      //  cellTextField.layer.borderWidth = 1.0
        cellTextField.textContentType = .emailAddress
        cellTextField.layer.masksToBounds = false
        cellTextField.font = .systemFont(ofSize: 17.0, weight: .regular)
        cellTextField.textContentType = .emailAddress
        return cellTextField
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
        
        addSubview(accountCellTextField)
        accountCellTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsAccountMenuDelegate) {
        
        
        accountCellTextField.placeholder = viewModel.placeholder
        iconImageView.image = UIImage(named:viewModel.image!)
        
        
    }
}

