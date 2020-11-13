//
//  SettingsController.swift
//  itaxo
//
//  Created by Genuine on 05.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

private let reuseIdentifierAccountCell = "AccountSettingsCell"
private let reuseIdentifierProgrammeCityCell = "AccountProgrammeCitySettingsCell"
private let reuseIdentifierProgrammeLanguageCell = "AccountProgrammeLanguageSettingsCell"

class SettingsViewController: UIViewController{
    
    let disposeBag = DisposeBag()
    var tableView : UITableView!
    
    
    lazy var userName: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Ваше ім’я",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                         NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
        ])
        field.textContentType = .name
        field.delegate = self
        return field
    }()
    
    lazy var userPhone: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Номер телефону",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                         NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
        ])
        field.textContentType = .telephoneNumber
        return field
    }()
    
    lazy var userEmail: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Ваш е-мейл",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                         NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
        ])
        field.textContentType = .emailAddress
        return field
    }()
    
    lazy var userPassword: UITextField = {
        let field = UITextField()
        field.attributedPlaceholder = NSAttributedString(
            string: "Введіть пароль",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: "#939393ff")! ,
                         NSAttributedString.Key.font:  UIFont(name: "Roboto-Regular", size: 15)!
        ])
        field.textContentType = .password
        return field
    }()
    
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
         self.userName.delegate = self
         self.userPassword.delegate = self
         self.userEmail.delegate = self
         self.userPhone.delegate = self
        //  configureHeaderTableView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = 150
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
        
//        let topLayoutGuideBox = UIView()
//        topLayoutGuideBox.backgroundColor = .green
//        self.view.addSubview(topLayoutGuideBox)
//
//        topLayoutGuideBox.snp.makeConstraints { (make) -> Void in
//        }

        tableView.tableFooterView!.snp.makeConstraints{(make) -> Void in
            make.bottom.equalTo(view.snp.bottom).inset(50)
        }
    }
    
    
    
    func configureTopHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderTopDelegate?
        
        guard let headerView = SettingsHeaderViewComponent(frame: .zero) as? SettingsHeaderViewComponent else {
                fatalError("Unexpected Header")
        }
        
        // добавляем хендлер тапа для дисмиса экрана настроек
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSettingsMenu))
        headerView.button.addGestureRecognizer(tap)
        tap.rx.event.bind(onNext: { recognizer in
            print("touches: \(recognizer.numberOfTouches)")
        }).disposed(by: disposeBag)
        
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel )
        }

        return headerView
    }
    
    func configureAccountHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderAccountDelegate?
        
        guard let headerView = SettingsAccountHeaderViewComponent(frame: .zero)
            as? SettingsAccountHeaderViewComponent else {
                fatalError("Unexpected Header")
        }
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel)
        }
        return headerView
    }
    
    func configureProgrammeHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderProgrammeDelegate?
        
        guard let headerView = SettingsProgrammeHeaderViewComponent(frame: .zero)
            as? SettingsProgrammeHeaderViewComponent else {
                fatalError("Unexpected Header")
        }
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
        let button: UIButton = {
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

        footerView.addSubview(button)
        button.snp.makeConstraints{(make) -> Void in
            make.left.equalTo(25)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerY.equalToSuperview()
            //   make.top.equalToSuperview().offset(10)
        }
        // view.addSubview(footerView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSettingsMenu))
        button.addGestureRecognizer(tap)
        tap.rx.event.bind(onNext: { recognizer in
            print("touches: \(recognizer.numberOfTouches)")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as! AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userName, imageLabel: "avatar icon"))
            cell.addField(testInput: userName)
            
            return cell
            
        case (0, 1):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as! AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userPhone, imageLabel: "tel icon"))
            cell.addField(testInput: userPhone)
            
            return cell
            
        case (0, 2):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as! AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userEmail, imageLabel: "mail"))
            cell.addField(testInput: userEmail)
            
            return cell
            
        case (0, 3):
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as! AccountSettingsCell
            
            cell.configure(withViewModel: SettingsViewModel(textInput: userPassword, imageLabel: "key"))
            cell.addField(testInput: userPassword)
            
            return cell
            
            //Настройки программы
            
        case (1, 0):
            guard let programmeSettings = SettingsViewModel.programmeSettings(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierProgrammeCityCell, for: indexPath) as! AccountProgrammeCitySettingsCell
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
    
    @objc func dismissSettingsMenu() {
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
