//
//  AccountSettingsCell.swift
//  itaxo
//
//  Created by Genuine on 06.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit

class AccountSettingsCell: UITableViewCell {
    
    var viewModel: SettingsViewModel?
    
    let iconImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.clipsToBounds = true
        return iconView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsViewModel) {
        
        self.viewModel = viewModel
        guard let _ = viewModel.textInput,
            let imageView = viewModel.image
            else { return }
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(self.contentView.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
    }
    
    
    func addField(testInput: UITextField) {
        guard let viewModel = self.viewModel,
            let imageView = viewModel.image else { return }
        testInput.layer.zPosition = 1000
        
        contentView.addSubview(testInput)
        
        testInput.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            testInput.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 25),
            testInput.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            testInput.heightAnchor.constraint(equalToConstant: 20),
            testInput.widthAnchor.constraint(equalToConstant: 130),
        ])
    }
}

