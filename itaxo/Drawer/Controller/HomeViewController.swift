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

class HomeController: UIViewController {
    let disposeBag = DisposeBag()
    weak var delegate: HomeControllerDelegate?
    var mapView: UIView?
    var menuController: UIViewController!
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
        mapViewController.menuButton.addTarget(self, action: #selector(handleMenu), for: .touchUpInside)
        
        mapView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
          
        // добавляем хендлер тапа
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMenu))
       // mapView.addGestureRecognizer(tap)
        view.addGestureRecognizer(tap)
        tap.rx.event.bind(onNext: { recognizer in
            print("touches: \(recognizer.numberOfTouches)")
        }).disposed(by: disposeBag)

        
        //adding menu view controller
        
        guard let menuController = menuController,
              let menuView = menuController.view

        else { return }

        self.menuController = menuController

        addChild(menuController)
        view.addSubview(menuView)

        menuController.didMove(toParent: self)
        let screenWidth = UIScreen.main.bounds.width
        self.menuWidth = screenWidth * 0.8
        menuView.frame.size.width = menuWidth
        
        menuView.frame.origin.x = menuWidth * -1

     
    }
    
    func configureMenuController() {
        //add our menu controller
        menuController = MenuController()
        menuController.view.frame.origin.x = CGFloat(self.menuWidth * -1)
        view.addSubview(menuController.view)
        menuController.didMove(toParent: self)
        print("configure MenuController")
    }
    
    /// Perform animation for showing and  folding drawer view
    func showMenuController(shouldExpand:Bool) {
        if shouldExpand {
            //show Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.menuController.view.frame.origin.x = 0
                 self.menuController.view.frame.origin.y = 20
                // TODO        //    self.mapView?.alpha = 0.5
                self.menuController.view.snp.makeConstraints { maker in
                                   maker.width.equalTo(self.view).multipliedBy(0.8)
                                   maker.edges.equalTo(self.view)
                               }
            }, completion: nil)
        } else {
            //hide Drawer menu
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.menuController.view.frame.origin.x = self.menuWidth * -1
                 self.menuController.view.frame.origin.y = 30
                self.mapView? .alpha = 1
            }, completion: nil)
        }
    }
}

extension HomeController: HomeControllerDelegate {
    
    //handle menu is responsible for state
    @objc func handleMenu() {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded = !isExpanded
        showMenuController(shouldExpand: isExpanded)
    }
    
    
}
