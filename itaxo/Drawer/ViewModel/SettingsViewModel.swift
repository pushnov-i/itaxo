//
//  SettingsViewModel.swift
//  itaxo
//
//  Created by Genuine on 05.11.2020.
//  Copyright © 2020 Illia Pushnov. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

// протокол можно было бы тут обьявить потому что он не большой и в принципе удобнее для навгиации
class SettingsViewModel {
    
    var textInput: UITextField?
    var image: UIImageView?
    
    init(textInput: UITextField?, imageLabel: String?) {
        self.textInput = textInput
        self.image = UIImageView(image: UIImage(named: imageLabel!))
        self.image?.contentMode = .scaleAspectFit
    }
    
    
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
    
    struct TextFieldViewModel {
        
        let userDefaults = UserDefaults.standard
        private let bag = DisposeBag()
        
        
        
        
        func confirmButtonValid(username: Observable<String>, password: Observable<String> ,
                                phone: Observable<String> , email: Observable<String> ) -> Void { //}}-> Observable<Bool> {
            Observable.combineLatest(username, password, phone, email).observeOn(MainScheduler.instance)
                .map { (username, password, phone, email) -> Void in
                    print (" ---> \(username), \(password), \(phone), \(email)")
                        self.userDefaults.set(username, forKey: "Name")
                }
                .subscribe()
//            username.observeOn(MainScheduler.instance)
//                .subscribe(onNext:{userDefaults in
//                 self.userDefaults.set(username,forKey: "Name")
//            }).disposed(by: bag)
//
//            self.userDefaults.set(username,forKey: "Name")
//            self.userDefaults.set(password,forKey: "Password")
//            self.userDefaults.set(email,forKey: "Email")
//            self.userDefaults.set(phone,forKey: "Phone")
//           // print(self.userDefaults.set(username,forKey: "Name"))
//            return Observable.combineLatest(username, password, email, phone)
//            { (username, password, email, phone) in
//                return username.count > 0
//                    || password.count > 0
//                    || email.count > 0
//                    || phone.count > 0
//
//            }
        }
    }
    
    struct AccountSettings: SettingsAccountMenuDelegate {
        
        
        let accountSettings : accountSettings
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
    
    struct HeaderSettings: SettingsHeaderTopDelegate, SettingsHeaderAccountDelegate, SettingsHeaderProgrammeDelegate {
        var topHeader: String = "НАЛАШТУВАННЯ"
        var accountSettingsHeader: String = "Налаштування аккаунту                                                               "
        var programmeSettingsHeader: String = "Налаштування програми                                                              "
    }
}
