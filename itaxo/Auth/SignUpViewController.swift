//
//  SignUpViewController.swift
//  itaxo
//
//  Created by Illia Pushnov on 24.09.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {
    
    
    let logoUnderwear: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FFDE43ff")
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(PhoneFormCell.self, forCellReuseIdentifier: "formCell")
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            let tabbarHeight = tabBarController?.tabBar.frame.size.height ?? 65
            make.edges.equalTo(view).inset(UIEdgeInsets(top: -tabbarHeight, left: 0, bottom: 0, right: 0))
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 100, right: 0)
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.logoUnderwear.layer.opacity = 0
            }, completion: nil)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.logoUnderwear.layer.opacity = 1
        }, completion: nil)
    }
    
}


extension SignUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(logoUnderwear)
            logoUnderwear.snp.makeConstraints { (maker) in
                maker.top.equalTo(cell.contentView)
                maker.leading.equalTo(cell.contentView)
                maker.trailing.equalTo(cell.contentView)
                maker.bottom.equalTo(cell.contentView)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCell", for: indexPath) as! PhoneFormCell
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableView.superview!.frame.height * 0.55
        case 1:
            return tableView.superview!.frame.height * 0.45
        default:
            return 0
            
        }
    }
    
}


extension SignUpViewController: UITableViewDelegate {
    
}

class PhoneFormCell: UITableViewCell {
    
    let headLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.numberOfLines = 0
        headLabel.text = "Вас вітає Itaxo!"
        return headLabel
    }()
    
    let subheadLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.numberOfLines = 0
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        headLabel.attributedText = NSMutableAttributedString(string: "Будь ласка, вкажіть Ваш номер телефону\nі отримайте смс з кодом підтведження", attributes: attributes)
        return headLabel
    }()
    
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .phonePad
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Продовжити", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#FFDE43ff")
        button.titleEdgeInsets = UIEdgeInsets(top: 40, left: -20, bottom: 40, right: -20)
        button.layer.cornerRadius = 25
        return button
    }()
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalCentering
        stackView.spacing = 0
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {
        contentView.layoutMargins = UIEdgeInsets(top: 60, left: 22, bottom: 20, right: 22)
        container.addArrangedSubview(headLabel)
        container.addArrangedSubview(subheadLabel)
        container.addArrangedSubview(textField)
        container.addArrangedSubview(button)
        contentView.addSubview(container)
        
        container.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.layoutMargins)
            make.leading.equalTo(contentView.layoutMargins)
            make.trailing.equalTo(contentView.layoutMargins)
            make.bottom.equalTo(contentView.layoutMargins)
        }
        
        button.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


