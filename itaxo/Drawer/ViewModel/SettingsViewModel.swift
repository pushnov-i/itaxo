//
//  SettingsViewModel.swift
//  itaxo
//
//  Created by Genuine on 05.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit

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
        var textInput: UITextInput? {
            switch accountSettings {
            case .UserName : return UITextContentType.givenName as? UITextInput
                //                 case .UserPhoneNumber : return
                //                 case .UserEmail: return
            //                case .UserPassword : return
            default : return UITextContentType.emailAddress as? UITextInput
            }
        }
        var placeholder: String {
            switch accountSettings {
            case .UserName : return "Ваше ім’я"
            case .UserPhoneNumber : return "Номер телефону"
            case .UserEmail: return "Ваш е-мейл"
            case .UserPassword : return "Введіть пароль"
            }
        }
        
        var image: String? {
            switch accountSettings {
            case .UserName : return "avatar icon"
            case .UserPhoneNumber : return "tel icon"
            case .UserEmail: return "mail"
            case .UserPassword : return "key"
            }
        }
    }
    
    struct ProgrammeSettings:SettingsProgrammeMenuDelegate {
        let programmeSettings : programmeSettings
        var userCity : [String:String] = ["city":"Місто","cityText":"Київ"]
        var userLanguage = ["language":"Мова","languageText":"Українська"]
    }
    
    struct HeaderSettings:SettingsHeaderTopDelegate,SettingsHeaderAccountDelegate,SettingsHeaderProgrammeDelegate {
        var topHeader: String = "НАЛАШТУВАННЯ"
        var accountSettingsHeader: String = "Налаштування аккаунту                                                               "
        var programmeSettingsHeader: String = "Налаштування програми                                                              "
    }
}
