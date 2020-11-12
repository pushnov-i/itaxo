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

class SettingsHeaderViewComponent: UITableViewHeaderFooterView {
    
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
            make.left.equalTo(12)
          //  make.top.equalTo(button.snp.bottom).offset(15)
           // make.leading.equalTo(view.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        addSubview(button)
        button.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(40)
            make.width.equalTo(40)
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(10)
        }
    }
    
//    @objc func dismissSettingsMenu(sender : UIButton) {
//        dismiss(animated: true)
//      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderTopDelegate) {
        headerSettingsLabel.text = viewModel.topHeader
        print("1!")
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
        
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(250)
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
       // headerSettingsLabel.useUnderline()
        print("2!")
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
        headerSettingsLabel.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(50)
            make.width.equalTo(250)
            make.left.equalTo(12)
           // make.leading.equalTo(view.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withViewModel viewModel: SettingsHeaderProgrammeDelegate) {
       // headerSettingsLabel.translatesAutoresizingMaskIntoConstraints = false
        headerSettingsLabel.text = viewModel.programmeSettingsHeader
        headerSettingsLabel.layer.addWaghaBorder(edge: .top, color: UIColor.black, thickness: 1)
        headerSettingsLabel.textColor = .black
        contentView.backgroundColor = .white
    }
}


extension UILabel {
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)

    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        
        layer.addSublayer(border)
    }
}

extension CALayer {
func addWaghaBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
let border = CALayer()
switch edge {
case UIRectEdge.top:
border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
break
case UIRectEdge.bottom:
border.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
break
case UIRectEdge.left:
border.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.height)
break
case UIRectEdge.right:
border.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
break
default:
break
}
border.backgroundColor = color.cgColor;
self.addSublayer(border)
}
}
