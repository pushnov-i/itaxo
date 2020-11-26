//
//  MenuOption.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import UIKit


class DrawerViewModel {
    
    enum menuOption: Int {
        
        case Trips // "Мої поїздки"
        case Payment // "Оплата"
        case Help // "Допомога"
        case AboutService // "Про сервіс"
        case EcoProjects // "Еко-проекти"
        case Partners // "Партнери"
        case DriverRegistration // "Реєстрація водія"
        case MapOfGasStation // "Карта заправок"
        
    }
    // Header view
    
    enum userCredentials: Int {
        
        case User
    }
    
    struct UserCredentials : MenuOptionRepresentable {
        
        let userCredentials : userCredentials
        
        var description: String  {
            switch userCredentials.self {
            case .User: return "Пассажир Пассажирський"
            }
        }
        
        var image: String {
            switch userCredentials.self {
            case .User: return "drawerMenu/avatar"
            }
        }
        var state: Bool{
            switch userCredentials.self {
            case .User: return true
            }
        }
    }
    
    struct MenuOptionViewModel : MenuOptionRepresentable {
        
        let menuOption : menuOption
        
        var image: String{
            switch menuOption.self {
            case .Trips: return  "drawerMenu/arrows icon"
            case .Payment:return "drawerMenu/card icon"
            case .Help: return "drawerMenu/help icon"
            case .AboutService: return "drawerMenu/Info icon"
            case .EcoProjects: return "drawerMenu/leaf icon"
            case .Partners: return "drawerMenu/handshake icon"
            case .DriverRegistration: return "drawerMenu/driver icon"
            case .MapOfGasStation: return "drawerMenu/petroil station icon"
            }
        }
        
        var description: String {
            switch menuOption {
            case .Trips: return "Мої поїздки"
            case .Payment: return "Оплата"
            case .Help: return "Допомога"
            case .AboutService: return "Про сервіс"
            case .EcoProjects: return "Еко-проекти"
            case .Partners: return "Партнери"
            case .DriverRegistration: return "Реєстрація водія"
            case .MapOfGasStation: return "Карта заправок"
            }
        }
        
        var state : Bool {
            switch menuOption {
            case .Trips: return true
            case .Payment: return true
            case .Help: return true
            case .AboutService: return false
            case .EcoProjects: return true
            case .Partners: return true
            case .DriverRegistration: return false
            case .MapOfGasStation: return false
            }
        }
    }
}




