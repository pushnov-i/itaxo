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
        
        case Header // "Налаштування аккаунту "
        case UserName // "Ваше ім’я"
        case UserPhoneNumber // "Номер телефону"
        case UserEmail // "Ваш е-мейл"
        case UserPassword // "Введіть пароль"
        
    }
    
    enum programmeSettings: Int {
        case Header   //"Налаштування програми"
        case UserCity // "Місто"
        case City //"Київ"
        case UserLangauge // "Мова"
        case Langauge // "Українська"
        
    }
    
    
    
    struct AccountSettings {
        
      //  let accountSettings
        var header:String
        var userName:String
        var userPhoneNumber:String
        var userEmail:String
        var userPassword:String
        
    }
    
    struct ProgrammeSettings {
        var userCity: String
        var userLangauge: String
    }
}
