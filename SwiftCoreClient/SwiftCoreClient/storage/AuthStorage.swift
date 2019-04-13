//
//  AuthStorage.swift
 
//
//   Created by azharkova on 27.02.2019.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import Foundation

class AuthStorage {
    struct KeychainConfiguration {
        static let serviceName = "TouchMeIn"
        static let accessGroup: String? = nil
    }

 func saveUserCredentials(login: String, password: String) {
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: login,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            try passwordItem.savePassword(password)
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }

 func clearUserCredentials(_ login: String) {
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: login,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            try passwordItem.deleteItem()
        } catch {
            debugPrint("Error deleting keychain - \(error)")
        }
    }

    func getSavedCredentials(login: String) -> UserData? {
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: login,
                                                    accessGroup: KeychainConfiguration.accessGroup)

            return try? UserData(login: login, password: passwordItem.readPassword(), rememberMe: true)
        } catch {
            return nil
        }
    }
}
