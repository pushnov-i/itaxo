//
//  RideListHeaderView.swift
//  itaxo
//
//  Created by Genuine on 27.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import SnapKit
import RxSwift


class RideListHeaderView: UICollectionReusableView {
    
    // var reuseIdentifier = "headerRideList"
    
    let headerRideListLabel : UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        guard let customFont = UIFont(name: "Roboto-Regular", size: 17) else {
            fatalError("""
            Failed to load the "Roboto-Regular" font.
            """
            )
        }
        label.font = UIFontMetrics.default.scaledFont(for: customFont)
        label.adjustsFontForContentSizeCategory = true
        label.text = "МОЇ ПОЇЗДКИ"
        return label
    }()
    
    let button : UIButton = {
        let buttonView = UIButton()
        buttonView.backgroundColor = .clear
        buttonView.layer.cornerRadius = 25
        buttonView.setImage(UIImage(named: "settingsMenu/cancel icon"), for: .normal)
        return buttonView
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        print("add header")
        addSubview(headerRideListLabel)
        headerRideListLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(250)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.centerY.equalToSuperview().offset(35)
        }
        
        addSubview(button)
        button.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.leftMargin).inset(20)
            make.top.equalToSuperview().offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
