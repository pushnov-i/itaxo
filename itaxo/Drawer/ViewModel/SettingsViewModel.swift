//
//  SettingsViewModel.swift
//  itaxo
//
//  Created by Genuine on 05.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation

class SettingsViewModel {
    
    enum accountSettings: Int {
    //    case Header // "Налаштування аккаунту "
        case UserName // "Ваше ім’я"
        case UserPhoneNumber // "Номер телефону"
        case UserEmail // "Ваш е-мейл"
        case UserPassword // "Введіть пароль"
    }
    
    enum programmeSettings: Int {
     //   case Header   //"Налаштування програми"
        case UserCity // "Місто"
        case City //"Київ"
        case UserLangauge // "Мова"
        case Langauge // "Українська"
    }
    
    struct AccountSettings: SettingsAccountMenuDelegate {
        let accountSettings : accountSettings
        
        var placeholder: String {
            switch accountSettings {
     //       case .Header: return "Налаштування аккаунту "
            case .UserName : return "Ваше ім’я"
            case .UserPhoneNumber : return "Номер телефону"
            case .UserEmail: return "Ваш е-мейл"
            case .UserPassword : return "Введіть пароль"
            }
        }

        var image: String? {
            switch accountSettings {
       //               case .Header: return "avatar icon"
                      case .UserName : return "avatar icon"
                      case .UserPhoneNumber : return "tel icon"
                      case .UserEmail: return "mail"
                      case .UserPassword : return "key"
                      }
        }
    }
    
    struct ProgrammeSettings {
        var userCity: String
        var userLangauge: String
    }
}
