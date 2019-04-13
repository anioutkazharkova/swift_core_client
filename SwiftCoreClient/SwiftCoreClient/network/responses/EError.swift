//
//  EError.swift

//
//  Created by azharkova on 19.11.2017.
//  Copyright © 2019 azharkova. All rights reserved.
//

import Foundation
import  ObjectMapper

class EError: Mappable {
    var code: Int = 0
    var message: String? = ""

    var errorType: ErrorType = .other

    init() {}
    required init?(map: Map) {

    }
    convenience init(type: ErrorType) {
        self.init()
        self.errorType = type
        switch type {
        case .auth:
            message = "Пользователь не авторизован"
        case .canceled:
            message = "Запрос отменен"
        case .network:
            message = "Сетевое соединение отсутствует"
        default:
            message = "Отсутствует связь с сервером"
        }
    }

    func mapping(map: Map) {

        code <- map["code"]
        message <- map["message"]

    }
}

extension EError {
    public func processedMessage() -> String {
       if let range = message?.range(of: " JSON could not be serialized becouse of error".lowercased(), options: .caseInsensitive) {
        return "Отсутствует связь с сервером"
        }
        return message ?? ""
    }
}
