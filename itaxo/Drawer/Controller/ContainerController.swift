////
////  ContainerController.swift
////  itaxo
////
////  Created by Genuine on 28.10.2020.
////  Copyright © 2020 Illia Pushnov. All rights reserved.
////
//
//import UIKit
//import SnapKit
//
//class ContainerController: UIViewController {
//    
//    
//    //MARK: - Properties
//    
//    var menuController: UIViewController! // for one time adding menuController
//    var centerController: UIViewController!
//    var isExpanded = false
//    
//    // MARK - Init
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(hex: "#FFDE43ff")
//        configureMenuController()
//        configureHomeController()
//    }
//    
//    // MARK - Handlers
//    
//    func configureHomeController() {
//        let homeController = HomeController()
//        homeController.delegate = self
//        
//        // тут нам навигация не нужна, потому что появляется таббар сверху, и мы пока не собираемся делать никакие кастомные кнопки в верхней панели
//        
//        centerController =  homeController
//        
//        
//        homeController.view.frame.origin.y = 30
//        addChild(homeController)
//        homeController.didMove(toParent: self)
//        view.addSubview(homeController.view)
//        
//        guard let menuController = menuController else { return }
//
//        addChild(menuController)
//        view.addSubview(menuController.view)
//        menuController.didMove(toParent: self)
//        menuController.view.frame.origin.x = -375
//
//        
//    //Put it in to hide drawer 
////        menuController.view.snp.makeConstraints { maker in
////            maker.width.equalTo(view).multipliedBy(0.8)
////            maker.edges.equalTo(view)
////        }
//        
//        
//    }
//    
//    func configureMenuController() {
//        if menuController == nil {
//            //add our menu controller
//            menuController = MenuController()
//            menuController.view.frame.origin.x = -375
//            view.insertSubview(menuController.view, at: 0)
//            addChild(menuController)
//            menuController.didMove(toParent: self)
//        }
//    }
//    
//    /// Perform animation for showing and  folding drawer view
//    func showMenuController(shouldExpand:Bool) {
//        if shouldExpand {
//            //show Drawer menu
//           // configureHomeController()
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
//                self.menuController.view.frame.origin.x = 0
//                self.menuController.view.frame.origin.y = 30
//                self.centerController.view.alpha = 0.8
//            }, completion: nil)
//        } else {
//            //hide Drawer menu
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//                self.menuController.view.frame.origin.x = 0
//                self.menuController.view.frame.origin.y = 30
//                self.centerController.view.alpha = 1
//            }, completion: nil)
//        }
//    }
//}
//
//extension ContainerController: HomeControllerDelegate {
//    
//    //handle menu is responsible for state 
//    func handleMenu() {
//        if !isExpanded {
//            configureMenuController()
//        }
//        
//        isExpanded = !isExpanded
//        showMenuController(shouldExpand: isExpanded)
//    }
//    
//    
//}
