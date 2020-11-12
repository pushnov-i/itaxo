//
//  MenuController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

private let reuseIdentifier = "MenuOptionCell"

class MenuController: UIViewController {
    let disposeBag = DisposeBag()
    //MARK: - Properties
    var tableView : UITableView!
    
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureHeaderTableView()
        
        
        // добавляем хендлер тапа
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleSettingsMenu))
        tableView.tableHeaderView?.addGestureRecognizer(tap)
        tap.rx.event.bind(onNext: { recognizer in
            print("touches: \(recognizer.numberOfTouches)")
        }).disposed(by: disposeBag)
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
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 50
        tableView.isScrollEnabled = false
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureHeaderTableView()  {
        
        var viewModel : MenuOptionRepresentable?
        
        guard let headerView = HeaderViewComponent(frame: .zero) as? HeaderViewComponent else {
            fatalError("Unexpected Header")
        }
        
        
        guard let userCredentials = DrawerViewModel.userCredentials(rawValue: 0) else {
            fatalError("Unexpected Index Path")
            
        }
        viewModel = DrawerViewModel.UserCredentials(userCredentials: userCredentials)
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel)
          
        }
        tableView.tableHeaderView = headerView
    }
}

extension MenuController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var viewModel : MenuOptionRepresentable?
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MenuOptionCell else {
            fatalError("Unexpected Table View Cell")
        }
        
        guard let menuOption = DrawerViewModel.menuOption(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
        
        viewModel = DrawerViewModel.MenuOptionViewModel(menuOption: menuOption)
        
        if let viewModel = viewModel {
            cell.configure(withViewModel: viewModel)
            cell.selectionStyle = .none
        }
        return cell
    }
}

extension MenuController {
    
    @objc func handleSettingsMenu() {
            print("tapped!")
            let settingsViewController = SettingsViewController()
        self.present(settingsViewController, animated:true, completion:nil)
        
    }
}


