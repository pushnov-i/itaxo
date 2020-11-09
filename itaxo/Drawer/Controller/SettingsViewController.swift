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
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints{(make) -> Void in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
    //    func configureHeaderTableView()  {
    //
    //        var viewModel : MenuOptionRepresentable?
    //
    //        guard let headerView = HeaderViewComponent(frame: .zero) as? HeaderViewComponent else {
    //            fatalError("Unexpected Header")
    //        }
    //        guard let userCredentials = DrawerViewModel.userCredentials(rawValue: 0) else {
    //            fatalError("Unexpected Index Path")
    //
    //        }
    //        viewModel = DrawerViewModel.UserCredentials(userCredentials: userCredentials)
    //        if let viewModel = viewModel {
    //            headerView.configure(withViewModel: viewModel)
    //        }
    //        tableView.tableHeaderView = headerView
    //    }
}

extension SettingsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 1
        } else {
            return 1
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

