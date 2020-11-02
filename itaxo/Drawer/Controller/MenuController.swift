//
//  MenuController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MenuOptionCell"

class MenuController: UIViewController {
    
    //MARK: - Properties
    var tableView : UITableView!
 
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureHeaderTableView()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: tableView.tableHeaderView)
    }
    
    func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = 150
        header.backgroundColor = UIColor(hex: "#FFDE43ff")
       // configureHeaderTableView()
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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor  )
        ])
    }
    
    func configureHeaderTableView()  {
//        self.backgroundView = UIView(frame: self.bounds)
//        self.backgroundView.backgroundColor = UIColor(hex: "#FFDE43ff")
        guard let headerView = HeaderViewComponent(frame: .zero) as? HeaderViewComponent else {fatalError("Unexpected Header")}
        var viewModel : MenuOptionRepresentable?
        guard let userCredentials = DrawerViewModel.userCredentials(rawValue: 0) else { fatalError("Unexpected Index Path") }
        viewModel = DrawerViewModel.UserCredentials(userCredentials: userCredentials)
        if let viewModel = viewModel {
            headerView.configure(withViewModel: viewModel)
        }
        tableView.tableHeaderView = headerView
        headerView.backgroundColor = UIColor(hex: "#FFDE43ff")
        self.tableView.tableHeaderView = headerView
        print(headerView)
       // return headerView
    }
    
}

extension MenuController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? MenuOptionCell
            else {fatalError("Unexpected Table View Cell")}
        
        var viewModel : MenuOptionRepresentable?
        
        guard let menuOption = DrawerViewModel.menuOption(rawValue: indexPath.row) else { fatalError("Unexpected Index Path") }
        viewModel = DrawerViewModel.MenuOptionViewModel(menuOption: menuOption)
        if let viewModel = viewModel {
            cell.configure(withViewModel: viewModel)
        }
        return cell
    }
    
//    func tableView(tableView: UITableView,  tableHeaderView section: Int) -> UIView? {
//        if  tableView == tableView.self{
//        return tableView.tableHeaderView
//        } else {
//            return fatalError("Unexpected table viwew self") as! UIView
//        }
//        
//    }
}

