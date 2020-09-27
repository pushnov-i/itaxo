//
//  VerifyPhoneViewController.swift
//  itaxo
//
//  Created by Illia Pushnov on 25.09.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit


class VerifyPhoneViewController: UIViewController {
    
    var keyboardShown = false
    
    let subheadLabel: UILabel = {
        let headLabel = UILabel()
        headLabel.numberOfLines = 0
        let font = UIFont.systemFont(ofSize: 16)
        let attributes = [NSAttributedString.Key.font: font]
        headLabel.attributedText = NSMutableAttributedString(string: "Будь ласка, вкажіть Ваш номер телефону\nі отримайте смс з кодом підтведження", attributes: attributes)
        return headLabel
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(VerifyCell.self, forCellReuseIdentifier: "formCell")
        return tableView
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "nav/arrow"), for: .normal)
        return button
    }()
    
    let resendButton: UIButton = {
        let button = UIButton(type: .custom)
        let title = NSLocalizedString("Повторне надсилання коду", comment: "")
        let attributedString = NSAttributedString(string: title, attributes: TextAttributes.withFont(Font(size: 16)))
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }()
    
    private lazy var oneTimeCodeField: OneTimeCodeField = {
        let view = OneTimeCodeField()
        view.configure()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(makeTextfieldActive))
        view.addGestureRecognizer(gestureRecognizer)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (maker) in
            maker.edges.equalTo(view)
        }
        
        backButton.addTarget(self, action: #selector(popBack), for: .touchUpInside)
        resendButton.addTarget(self, action: #selector(resendCode), for: .touchUpInside)
        
        let leftItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftItem
        
        let rightButton = UIBarButtonItem(customView: resendButton)
        navigationItem.rightBarButtonItem = rightButton
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        tableView.addGestureRecognizer(tapGesture)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        oneTimeCodeField.becomeFirstResponder()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if keyboardShown { return }
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 80, right: 0)
            keyboardShown = true
        }
        
        
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        keyboardShown = false
        tableView.contentInset = .zero
    }
    
    @objc private func hideKeyboard() {
        tableView.endEditing(true)
    }
    
    @objc private func popBack() {
        tableView.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func resendCode() {
        
    }
    
    @objc private func makeTextfieldActive() {
        oneTimeCodeField.becomeFirstResponder()
    }
}

extension VerifyPhoneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return tableView.superview!.frame.height * 0.40
        case 1:
            return tableView.superview!.frame.height * 0.45
        default:
            return 0
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "formCell", for: indexPath) as! VerifyCell
            cell.setupViews(subheadLabel: subheadLabel, codeField: oneTimeCodeField)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}



class VerifyCell: AuthFormCell {
   
    func setupViews(subheadLabel: UILabel, codeField: OneTimeCodeField) {
        contentView.layoutMargins = UIEdgeInsets(top: 60, left: 22, bottom: 20, right: 22)
        
        let placeholder = UIView()
        placeholder.backgroundColor = .clear
        placeholder.setContentHuggingPriority(UILayoutPriority(rawValue: 1), for: .vertical)
        subheadLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        
        container.addArrangedSubview(placeholder)
        container.addArrangedSubview(headLabel)
        container.addArrangedSubview(subheadLabel)
        container.addArrangedSubview(codeField)
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
    
}
class OneTimeCodeField: UITextField {
    
    var digitsLabel: [CustomDigitLabel] = []
    
    private func configureTextField() {
        tintColor = .clear
        textColor = .clear
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    private func createNumbersStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 15
        
        for _  in 1 ... 6 {
            let label = CustomDigitLabel()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 32)
            label.backgroundColor = .clear
            
            label.isUserInteractionEnabled = true
            stackView.addArrangedSubview(label)
            
            digitsLabel.append(label)
        }
        
        return stackView
    }
    
    func configure(){
        let stackView = createNumbersStackView()
        configureTextField()
        delegate = self
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
              text.count <= digitsLabel.count else { return }
        
        for i in 0 ..< digitsLabel.count {
            let currentLabel = digitsLabel[i]
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


extension OneTimeCodeField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let charactersCount = textField.text?.count else { return false }
        return charactersCount < digitsLabel.count || string == ""
    }
}


class CustomDigitLabel: UILabel {
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override var text: String? {
        didSet {
            if text == nil || text == "" {
                self.bottomBorder.backgroundColor = .lightGray
            }
            else {
                self.bottomBorder.backgroundColor = .black
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(bottomBorder)
        bottomBorder.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(self).offset(5)
            maker.leading.equalTo(self)
            maker.trailing.equalTo(self)
            maker.height.equalTo(3)
        }
        
        self.snp.makeConstraints { (maker) in
            maker.height.equalTo(40)
        }
        
    }
}
