//
//  SettingsController.swift
//  itaxo
//
//  Created by Genuine on 05.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

private let reuseIdentifierAccountCell = "AccountSettingsCell"
private let reuseIdentifierProgrammeCityCell = "AccountProgrammeCitySettingsCell"
private let reuseIdentifierProgrammeLanguageCell = "AccountProgrammeLanguageSettingsCell"

class SettingsViewController: UIViewController {
    
    
    
    //MARK: - Properties
    var tableView : UITableView!
    
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
        tableView.tableFooterView = configureFooterViewButtonExit()
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{(make) -> Void in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    
    
    func configureTopHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderTopDelegate?
        
        guard let headerView = SettingsHeaderViewComponent(frame: .zero) as? SettingsHeaderViewComponent else {
            fatalError("Unexpected Header")
        }
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel )
        }
        return headerView
    }
    
    func configureAccountHeaderTableView() -> UIView?  {
        
        var viewModel : SettingsHeaderAccountDelegate?
        
        guard let headerView = SettingsAccountHeaderViewComponent(frame: .zero) as? SettingsAccountHeaderViewComponent else {
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
        
        guard let headerView = SettingsProgrammeHeaderViewComponent(frame: .zero) as? SettingsProgrammeHeaderViewComponent else {
            fatalError("Unexpected Header")
        }
        viewModel = SettingsViewModel.HeaderSettings()
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel )
        }
        return headerView
    }
    
    func configureFooterViewButtonExit() -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let button: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("Вийти", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(hex: "#FFDE43ff")
            button.titleEdgeInsets = UIEdgeInsets(top: 40, left: -20, bottom: 40, right: -20)
            button.layer.cornerRadius = 25
            button.isEnabled = true
            button.isUserInteractionEnabled = true
            return button
        }()
        
//        let buttonLabel: UILabel = {
//
//        }
        
        footerView.addSubview(button)
        button.snp.makeConstraints{(make) -> Void in
            make.left.right.bottom.top.equalToSuperview()
        }
        return footerView;
        //
        //        func myAction(_ sender : AnyObject) {
        //
        //           }
        
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
            return 1
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
    
     func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        } else {
            return 50
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            var viewModel : SettingsAccountMenuDelegate?
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierAccountCell, for: indexPath) as? AccountSettingsCell else {
                fatalError("Unexpected Table View Cell")
            }
            guard let accountSettings = SettingsViewModel.accountSettings(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            viewModel = SettingsViewModel.AccountSettings(accountSettings: accountSettings)
            
            if let viewModel = viewModel {
                cell.configure(withViewModel: viewModel)
                cell.selectionStyle = .none
            }
            return cell
        } else if indexPath.section == 1
        {
            var viewModel : SettingsProgrammeMenuDelegate?
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierProgrammeCityCell, for: indexPath) as? AccountProgrammeCitySettingsCell else {
                fatalError("Unexpected Table View Cell")
            }
            guard let programmeSettings = SettingsViewModel.programmeSettings(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            viewModel = SettingsViewModel.ProgrammeSettings(programmeSettings: programmeSettings)
            
            if let viewModel = viewModel {
                cell.configure(withViewModel: viewModel)
                cell.selectionStyle = .none
            }
            return cell
        } else {
            var viewModel : SettingsProgrammeMenuDelegate?
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierProgrammeLanguageCell, for: indexPath) as? AccountProgrammeLanguageSettingsCell else {
                fatalError("Unexpected Table View Cell")
            }
            guard let programmeSettings = SettingsViewModel.programmeSettings(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
            viewModel = SettingsViewModel.ProgrammeSettings(programmeSettings: programmeSettings)
            
            if let viewModel = viewModel {
                cell.configure(withViewModel: viewModel)
                cell.selectionStyle = .none
            }
            return cell
            
        }
    }
    
    
    
}

