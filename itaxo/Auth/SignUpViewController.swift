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


protocol AuthNavigationDelegate {
    func presentVerifyScreen()
}



class SignUpViewController: UIViewController, AuthNavigationDelegate, UITableViewDelegate {
    
    var keyboardShown = false
    var isLoaded = false
    
    let logoUnderwear: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FFDE43ff")
        let imageView = UIImageView(image: UIImage(named: "logo"))
        view.addSubview(imageView)
        imageView.contentMode = .center
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
        }
        view.addSubview(imageView)
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(AuthFormCell.self, forCellReuseIdentifier: "formCell")
        return tableView
    }()
    
    let subheadLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.numberOfLines = 0
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        headLabel.attributedText = NSMutableAttributedString(string: "Будь ласка, вкажіть Ваш номер телефону\nі отримайте смс з кодом підтведження", attributes: attributes)
        return headLabel
    }()
    
    lazy var textField: PhoneField = {
        let textField = PhoneField()
        textField.configure()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(makeTextfieldActive))
        textField.addGestureRecognizer(gestureRecognizer)
        return textField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        self.extendedLayoutIncludesOpaqueBars = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.isLoaded = true
            strongSelf.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if keyboardShown { return }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 80, right: 0)
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                self?.logoUnderwear.layer.opacity = 0
                }, completion: nil)
            keyboardShown = true
            tableView.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: true)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        keyboardShown = false
        tableView.contentInset = .zero
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            self?.logoUnderwear.layer.opacity = 1
            }, completion: nil)
    }
    
    func presentVerifyScreen() {
        let vc = VerifyPhoneViewController()
        show(vc, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc private func hideKeyboard() {
        tableView.endEditing(true)
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCell", for: indexPath) as! AuthFormCell
        cell.setupViews(subheadLabel: subheadLabel, textField: textField)
        cell.contentView.isUserInteractionEnabled = true
        cell.delegate = self
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableView.superview!.frame.height * (isLoaded ? 0.55 : 1.0)
        case 1:
            return tableView.superview!.frame.height * 0.45
        default:
            return 0
            
        }
    }
    
    @objc private func makeTextfieldActive() {
        textField.becomeFirstResponder()
    }
    
}


class AuthFormCell: UITableViewCell {
    
    open weak var delegate: SignUpViewController?
    
    let headLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.numberOfLines = 0
        headLabel.text = "Вас вітає Itaxo!"
        headLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return headLabel
    }()
    
    let button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Продовжити", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#FFDE43ff")
        button.titleEdgeInsets = UIEdgeInsets(top: 40, left: -20, bottom: 40, right: -20)
        button.layer.cornerRadius = 25
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        return button
    }()
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
    }
    
    func setupViews(subheadLabel: UILabel, textField: PhoneField) {
        contentView.layoutMargins = UIEdgeInsets(top: 60, left: 22, bottom: 20, right: 22)
        
        let placeholder = UIView()
        placeholder.backgroundColor = .clear
        placeholder.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        
        container.addArrangedSubview(placeholder)
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
        
        button.addTarget(self, action: #selector(proceed), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func proceed() {
        delegate?.presentVerifyScreen()
    }
    
}



class PhoneField: UITextField {
    
    var phoneLabels: [UILabel] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .telephoneNumber
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    
    func configure() {
        configureTextField()
        let stackView = UIStackView()
        self.delegate = self
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let flagImage = UIImageView(image: UIImage(named: "nav/UkrFlag"))
        flagImage.contentMode = .center
        
        
        let arrowImage = UIImageView(image: UIImage(named: "nav/arrowdown"))
        arrowImage.contentMode = .center
        
        let prefixLabel = UILabel()
        prefixLabel.text = "+380"
        prefixLabel.font = UIFont.systemFont(ofSize: 18)
        
        let prefixContainer = UIView()
        prefixContainer.addSubview(prefixLabel)
        prefixLabel.snp.makeConstraints { (maker) in
            maker.edges.equalTo(prefixContainer).inset(UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0))
        }
        
        stackView.addArrangedSubview(flagImage)
        stackView.addArrangedSubview(arrowImage)
        stackView.addArrangedSubview(prefixContainer)
        
        for _index in 1 ... 9 {
            let container = UIView()
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.text = " "
            container.addSubview(label)
            label.snp.makeConstraints { (maker) in
                maker.top.equalTo(container).offset(-3)
                maker.leading.equalTo(container)
                maker.trailing.equalTo(container)
                maker.bottom.equalTo(container)
            }
            stackView.addArrangedSubview(container)
            let customSpacing = (_index  == 2 || _index == 5 || _index == 7) ? 15 : 5
            stackView.setCustomSpacing(CGFloat(customSpacing), after: container)
            phoneLabels.append(label)
        }
        
        let placeholder = UIView()
        placeholder.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .horizontal)
        stackView.addArrangedSubview(placeholder)
        addSubview(stackView)
        
        stackView.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(self)
            maker.leading.equalTo(self)
            maker.top.equalTo(self)
            maker.bottom.equalTo(self)
        }
    }
    
    @objc private func textDidChange() {
        guard let text = self.text,
            text.count <= phoneLabels.count else { return }
        
        for i in 0 ..< phoneLabels.count {
            let currentLabel = phoneLabels[i]
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
            }
            else {
                currentLabel.text?.removeAll()
            }
        }
    }
    
}


extension PhoneField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charactersCount = textField.text?.count else { return false }
        return charactersCount < phoneLabels.count || string == ""
    }
}
