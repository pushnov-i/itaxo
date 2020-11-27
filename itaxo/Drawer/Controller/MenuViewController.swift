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

class MenuViewController: UIViewController {
    let disposeBag = DisposeBag()
    //MARK: - Properties
    var tableView : UITableView!
   
    // MARK - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureHeaderTableView()
        
        
        // добавляем хендлер тапа
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(handleSettingsMenu))
        tableView.tableHeaderView?.addGestureRecognizer(headerTap)
        headerTap.rx.event.bind(onNext: { recognizer in
            print("touches headerview : \(recognizer.numberOfTouches)")
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
        tableView.isUserInteractionEnabled = true
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
    
    func shouldTapRow(_ touch: CGPoint) -> Bool {
        guard let indexPath = tableView.indexPathForRow(at: touch) else { return false }
        tableView(self.tableView, didSelectRowAt: indexPath)
        return true
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath)")
        if indexPath.row == 0 {
            
            
//
//            func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//                guard let drawerView = handleDrawerMenuTap.view,
//                      let otherView = otherGestureRecognizer.view else { return false }
//                
//                return gestureRecognizer == myScreenEdgePanGestureRecognizer &&
//                       otherView.isDescendant(of: drawerView)}
//            
//            
            //            func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
            //                     shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            //               // Don't recognize a single tap until a double-tap fails.
            //               if gestureRecognizer == self.tap &&
            //                      otherGestureRecognizer == self.doubleTapGesture {
            //                  return true
            //               }
            //               return false
            //            }
            
            //            let myScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action:#selector(handleScreenEdgePan))
            //            myScreenEdgePanGestureRecognizer.delegate = self
            //                // Configure the gesture recognizer and attach it to the view.
            //
            //            ...
            //
            //            func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            //                guard let myView = myScreenEdgePanGestureRecognizer.view,
            //                      let otherView = otherGestureRecognizer.view else { return false }
            //
            //                return gestureRecognizer == myScreenEdgePanGestureRecognizer &&
            //                       otherView.isDescendant(of: myView)}1
            //
            //
            //            tableView.cellForRow(at: indexPath)?.contentView
            //
            //                .rx
            //            .tapGesture()
            //            .when(.recognized)
            //            .subscribe(onNext: { _ in
            //              handleRideList()
            //            })
            //            .disposed(by: disposeBag)
            //
            
        }
        print(indexPath.row)
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

extension MenuViewController {
    
    @objc func handleSettingsMenu() {
        let settingsViewController = SettingsViewController()
        self.present(settingsViewController, animated:true, completion:nil)
    }
    
    func handleRideList() {
        let settingsViewController = RideListViewController()
        self.present(settingsViewController, animated:true, completion:nil)
    }
    
}
extension MenuViewController : UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view!.isDescendant(of: tableView) {
            return false
        }
        return true
    }
}


