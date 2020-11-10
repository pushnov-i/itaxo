//
//  Protocols.swift
//  itaxo
//
//  Created by Genuine on 28.10.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//
import UIKit

protocol HomeControllerDelegate: class {
    func handleMenu()
}

protocol MenuOptionRepresentable {
    var description: String { get }
    var image: String { get }
    var state: Bool {get}
}

protocol SettingsAccountMenuDelegate {
     var placeholder: String { get }
     var image: String? { get }
}

protocol SettingsProgrammeMenuDelegate{
    var userCity: [String:String] { get }
    var userLanguage: [String:String] { get }
}

protocol SettingsHeaderTopDelegate{
    var topHeader : String {get}

}
protocol SettingsHeaderAccountDelegate{
   var accountSettingsHeader : String {get}
}

protocol SettingsHeaderProgrammeDelegate{
   var programmeSettingsHeader : String {get}

}







