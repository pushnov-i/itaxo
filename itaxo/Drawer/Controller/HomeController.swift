//
//  HomeController.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit
import SnapKit

class HomeController: UIViewController {
    weak var delegate: HomeControllerDelegate?
    var mapView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeController()
    }
    
    // MARK - Handlers
    @objc func handleMenu() {
        delegate?.handleMenu()
        print("MenuTap")
    }
    
    func configureHomeController() {

        view.backgroundColor = .darkGray
        view.isUserInteractionEnabled = true
        // добавляем на подложку мап вью контроллер
        
        let mapViewController = MapViewController()
        
        
        // guard я использую восновном чтобы делать анврап и, что _очень важно_ избегать глубокой вложенности (нужно везде стараться это делать). тут если  использовать if то получается + 1 уровень вложенности кода, сравни с предыдущим коммитом. если можно избежать лишней вложенности - лучше избегать. тут понятно, что если вью из контроллера не получили, не нефиг дергатся, тоесть это не случится грубо говоря никогда
        
        guard let mapView = mapViewController.view else { return }
        
        addChild(mapViewController)
        view.addSubview(mapViewController.view)
        mapView.didMoveToWindow()
        
        mapView.snp.makeConstraints { maker in
            maker.edges.equalTo(view)
        }
        
        
        // добавляем хендлер тапа теперь уже на мап вью, тк он сверху, под меню, но и над контейнером (переменной view в данном случае)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleMenu))
        mapView.addGestureRecognizer(tap)
        
        
    }
}
