//
//  SettingsController.swift
//  itaxo
//
//  Created by Genuine on 05.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import CoreData

private let reuseIdentifierAccountCell = "AccountSettingsCell"
private let reuseIdentifierProgrammeCityCell = "AccountProgrammeCitySettingsCell"
private let reuseIdentifierProgrammeLanguageCell = "AccountProgrammeLanguageSettingsCell"
var users: [NSManagedObject] = []

class SettingsViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    var tableView : UITableView!
    var exitButton : UIButton!
    let textFiledsViewModel = SettingsViewModel.TextFieldViewModel()
    
    
    lazy var userName: UITextField = {
        let field = UITextField()
        field.textContentType = .name
        field.textColor = .black
        switch users.count {
        case 0 :
            field.attributedPlaceholder = NSAttributedString(
                string: "Ваше ім’я",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                             NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
            ])
            field.delegate = self
            return field
        default :
            
            let userName = users[0].value(forKey: "name") as? String
            field.text = userName
            field.delegate = self
            return field
        }
    }()
    
    lazy var userPhone: UITextField = {
        let field = UITextField()
        field.textContentType = .telephoneNumber
        field.textColor = .black
        switch users.count {
        case 0 :
            field.attributedPlaceholder = NSAttributedString(
                string: "Номер телефону",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                             NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
            ])
            field.delegate = self
            return field
        default :
            
            let userName = users[0].value(forKey: "phone") as? String
            field.text = userName
            field.delegate = self
            return field
        }
    }()
    
    
    lazy var userEmail: UITextField = {
        let field = UITextField()
        field.textContentType = .emailAddress
        field.textColor = .black
        
        switch users.count {
        case 0 :
            field.attributedPlaceholder = NSAttributedString(
                string: "Ваш е-мейл",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                             NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
            ])
            field.delegate = self
            return field
        default :
            
            let userName = users[0].value(forKey: "email") as? String
            field.text = userName
            field.delegate = self
            return field
        }
    }()
    
    lazy var userPassword: UITextField = {
        let field = UITextField()
        field.textContentType = .password
        field.textColor = .black
        
        switch users.count {
        case 0 :
            field.attributedPlaceholder = NSAttributedString(
                string: "Введіть пароль",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                             NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!])
            field.delegate = self
            return field
            
        default :
            let userName = users[0].value(forKey: "password") as? String
            field.text = userName
            field.delegate = self
            return field
        }
    }()
    
    
    
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.userName.delegate = self
        self.userPassword.delegate = self
        self.userEmail.delegate = self
        self.userPhone.delegate = self
        
        let username = self.userName.rx.text.orEmpty.asObservable()
        let password = self.userPassword.rx.text.orEmpty.asObservable()
        let email = self.userEmail.rx.text.orEmpty.asObservable()
        let phone = self.userPhone.rx.text.orEmpty.asObservable()
        
        textFiledsViewModel.confirmButtonValid(username: username, password: password, phone: phone, email: email)
        print(" ALL USERS \(users)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
        
    }
    
    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = 100
    }
    
    // MARK - Handlers
    func configureTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountSettingsCell.self, forCellReuseIdentifier: reuseIdentifierAccountCell)
        tableView.register(AccountProgrammeCitySettingsCell.self, forCellReuseIdentifier: reuseIdentifierProgrammeCityCell)
        tableView.register(AccountProgrammeLanguageSettingsCell.self, forCellReuseIdentifier: reuseIdentifierProgrammeLanguageCell)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = configureTopHeaderTableView()
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = false
        tableView.tableFooterView = configureFooterViewButtonExit()
        view.backgroundColor = UIColor(hex: "#FFDE43ff")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints{(make) -> Void in
            
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.leftMargin)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.rightMargin)
            make.top.equalTo( view.safeAreaLayoutGuide.snp.topMargin).inset(20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottomMargin).inset(20)
        }
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    
    func configureTopHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderTopDelegate?
        let headerView = SettingsTopHeaderViewComponent(frame: .zero)        
        // добавляем хендлер тапа для дисмиса экрана настроек
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSettingsMenu))
        headerView.button.addGestureRecognizer(tap)
        tap.rx.event.bind(onNext: { recognizer in
            print("cancel button")
        }).disposed(by: disposeBag)
        
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel )
        }
        
        return headerView
    }
    
    func configureAccountHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderAccountDelegate?
        let headerView = SettingsAccountHeaderViewComponent(frame: .zero)
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel)
        }
        headerView.addBorder( side: .bottom, thickness: 10, color: UIColor.black)
        return headerView
    }
    
    func configureProgrammeHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderProgrammeDelegate?
        let headerView = SettingsProgrammeHeaderViewComponent(frame: .zero)
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel )
        }
        return headerView
    }
    
    func configureFooterViewButtonExit() -> UIView? {
        let cancelImageView = UIImage(named: "exitLabel")
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        footerView.isUserInteractionEnabled = true
        exitButton = {
            let button = UIButton(type: .custom)
            button.setImage(cancelImageView, for: .normal)
            button.setTitle("Вийти", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor(hex: "#FFDE43ff")
            button.titleEdgeInsets = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 10)
            button.layer.cornerRadius = 25
            button.isEnabled = true
            button.isUserInteractionEnabled = true
            return button
        }()
        
        footerView.addSubview(exitButton)
        exitButton.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(12)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerY.equalToSuperview().offset(15)
            
        }
        view.addSubview(footerView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(exitFromAccountSettings))
        exitButton.addGestureRecognizer(tap)
        tap.rx.event.bind(onNext: { recognizer in
            print("Exit")
        }).disposed(by: disposeBag)
        return footerView;
    }
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section)  {
        case 0 : return 4
        case 1 :return 1
        case 2 :return 1
            
        default:
            fatalError()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        switch (section)  {
            
        case 0 : return configureAccountHeaderTableView()
        case 1 :return configureProgrammeHeaderTableView()
            
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView,heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 0
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section, indexPath.row) {
        //Настройки аккаунта
        case (0, 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as!
            AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userName, imageLabel: "avatar icon"))
            cell.addField(testInput: userName)
            
            return cell
            
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as!
            AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userPhone, imageLabel: "tel icon"))
            cell.addField(testInput: userPhone)
            
            return cell
            
        case (0, 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as!
            AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userEmail, imageLabel: "mail"))
            cell.addField(testInput: userEmail)
            
            return cell
            
        case (0, 3):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as!
            AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userPassword, imageLabel: "key"))
            cell.addField(testInput: userPassword)
            
            return cell
            
            //Настройки программы
            
        case (1, 0):
            guard let programmeSettings = SettingsViewModel.programmeSettings(rawValue: indexPath.row) else
            { fatalError("Unexpected Index Path") }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierProgrammeCityCell, for: indexPath) as!
            AccountProgrammeCitySettingsCell
            cell.configure(withViewModel:SettingsViewModel.ProgrammeSettings(programmeSettings: programmeSettings))
            
            return cell
            
            
        case (2, 0):
            guard let programmeSettings = SettingsViewModel.programmeSettings(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierProgrammeLanguageCell, for: indexPath) as! AccountProgrammeLanguageSettingsCell
            cell.configure(withViewModel:SettingsViewModel.ProgrammeSettings(programmeSettings: programmeSettings))
            return cell
            
        default:
            fatalError("wtf")
        }
    }
    
    @objc func dismissSettingsMenu(sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func exitFromAccountSettings(sender: UIButton) {
        print("exit func ")
        
        self.save(name: userName.text!, email: userEmail.text! , password: userPassword.text! , phone:  userPhone.text!)
        
        dismiss(animated: true, completion: nil)
    }
}

//NEXT keyboard
extension SettingsViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.userName:
            self.userPhone.becomeFirstResponder()
        case self.userPhone:
            self.userEmail.becomeFirstResponder()
        case self.userEmail:
            self.userPassword.becomeFirstResponder()
        default:
            () //make action after filling all textfields
        }
        return true
    }
}

extension SettingsViewController {
    func save(name: String, email : String , password: String,phone : String) {
        let user = CoreDataManager.sharedManager.insertUser(name: name, email : email , password: password,phone : phone)
        if user != nil {
            users.append(user!)//3
            
            print(" THIS IS user name : \(users[0].value(forKey: "name") as? String)")
            userName.reloadInputViews()//4
        }
    }
    
}
