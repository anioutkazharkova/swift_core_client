//
//  Storage.swift

//
//   Created by azharkova on 27.02.2019.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import Foundation

class Storage: NSObject {

  private lazy var storage = UserDefaults.standard

    private func saveData<T: Any&Codable>(data: T?, forKey: String) {
        storage.removeObject(forKey: forKey)
   guard let data = data, let encodedData =  try? JSONEncoder().encode(data) else {
    return
        }
        storage.set(encodedData, forKey: forKey)
        storage.synchronize()
    }

    private func getData<T: Any&Codable>(forKey: String) -> T? {
        if  let decoded = storage.object(forKey: forKey) as? Data {
            return try? JSONDecoder().decode(T.self, from: decoded)
        } else {
            return nil
        }
    }

    func saveLoginData(user: UserData) {
        saveData(data: user, forKey: UserData.key)
    }

    func getLoginData() -> UserData? {
    return getData(forKey: UserData.key)
    }

    func clearLoginData() {
         storage.removeObject(forKey: UserData.key)
        storage.synchronize()
    }

    func saveToken(token: DeviceToken) {
        saveData(data: token, forKey: DeviceToken.key)
    }

    func getToken() -> DeviceToken? {
        return getData(forKey: DeviceToken.key)
    }

    func clearTokenData() {
        storage.removeObject(forKey: DeviceToken.key)
        storage.synchronize()
    }

}
