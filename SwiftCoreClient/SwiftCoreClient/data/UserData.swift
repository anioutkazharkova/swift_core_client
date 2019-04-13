//
//  UserData.swift

//
//   Created by azharkova on 27.02.2019.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var login: String?
    var password: String?
    var rememberMe: Bool = false

    static let key = "user_data"
}
