//
//  HomeController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    let disposeBag = DisposeBag()
    weak var delegate: HomeControllerDelegate?
    var mapView: UIView?
    var menuController: MenuViewController!
    var isExpanded = false
    var menuWidth: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMenuController()
        configureHomeController()
    }
    
    func configureHomeController() {
        
        view.backgroundColor = UIColor(hex: "#FFDE43ff")
        view.isUserInteractionEnabled = true
        // добавляем на подложку мап вью контроллер
        
        let mapViewController = MapViewController()
        guard let mapView = mapViewController.view else { return }
        
        addChild(mapViewController)
        view.addSubview(mapViewController.view)
        mapView.didMoveToWindow()
        mapViewController.didMove(toParent: self)
        mapViewController.menuButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
        
        mapView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
        
        // добавляем хендлер тапа
        //let doubleTap =
        let handleDrawerMenuTap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        handleDrawerMenuTap.delegate = self

        self.menuController = MenuViewController()
        guard let menuView = menuController.view else { return }

        
        menuController.view.addGestureRecognizer(handleDrawerMenuTap)
        handleDrawerMenuTap.rx.event.bind(onNext: { recognizer in
            print("handle drwer menu touches number: \(recognizer.numberOfTouches)")
        }).disposed(by: disposeBag)
        
        
        addChild(menuController)
        view.addSubview(menuView)
        menuController.didMove(toParent: self)
        let screenWidth = UIScreen.main.bounds.width
        self.menuWidth = screenWidth * 0.8
        menuView.frame.size.width = menuWidth
        menuView.frame.origin.x = menuWidth * -1
        
        
    }
    
    //TODO fix bug with creating of multiple menu views
    
    func configureMenuController() {
        //add our menu controller
//        menuController = MenuController()
//        menuController.view.frame.origin.x = CGFloat(self.menuWidth * -1)
//        view.addSubview(menuController.view)
//        menuController.didMove(toParent: self)
//        print("configure MenuController")
    }
    
    /// Perform animation for showing and  folding drawer view
    func showMenuController(shouldExpand:Bool) {
        if shouldExpand {
            //show Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.menuController.view.frame.origin.x = 0
                self.menuController.view.frame.origin.y = 0
                // TODO
                self.mapView?.alpha = 1
                self.menuController.view.snp.makeConstraints { maker in
                    maker.width.equalTo(self.view).multipliedBy(0.8)
                    maker.edges.equalTo(self.view)
                }
            }, completion: nil)
        } else {
            //hide Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.menuController.view.frame.origin.x = self.menuWidth * -1
                self.menuController.view.frame.origin.y = 0
                // self.mapView? .alpha = 1
            }, completion: nil)
        }
    }
}

extension HomeViewController: HomeControllerDelegate {
    
    //handle menu is responsible for state
    
    @objc func toggleMenu() {
        if !isExpanded {
            dismiss(animated: true, completion: nil)
            // configureMenuController()
        }
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
        
    }
    
    @objc func handleTap(sender: UIGestureRecognizer) {
        
        let pointOfTap = sender.location(in: menuController.tableView)
        
        if !menuController.shouldTapRow(pointOfTap) {
            toggleMenu()
        }

    }
    
    
}


