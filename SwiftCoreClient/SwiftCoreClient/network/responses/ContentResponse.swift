//
//  ContentResponse.swift
//  MoviesSearch
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit
import ObjectMapper

enum ErrorType {
    case network, tech, auth, canceled, other
}

class ContentResponse<T: Any&Mappable> {
    var content: T?
    var contentArray: [T]?
    var error: EError?
    var code: Int = 0
    var canceled: Bool = false
    init() {}

  convenience init(response: HTTPURLResponse, json: Any) {
        self.init()
        code = response.statusCode
    let result = json is String ? Mapper<T>().map(JSONString: json as! String) : Mapper<T>().map(JSONObject: json)
    let resultArray = json is String ? Mapper<T>().mapArray(JSONString: json as! String) : Mapper<T>().mapArray(JSONObject: json)
  error = json is String ? Mapper<EError>().map(JSONString: json as! String) : Mapper<EError>().map(JSONObject: json)
    switch (code) {
    case 200..<300:
        error = nil
        break
    case 401, 403:
        error?.message = "Пользователь не авторизован"
        error?.errorType = .auth
        break
    case 500, 503:
        error?.message = "Сервис временно недоступен. Повторите попытку позже"
        error?.errorType = .tech
    default:
        break
    }

    content = result
    contentArray = resultArray
    }

    convenience init(error: EError) {
        self.init()
        self.error = error
        self.canceled = error.errorType == .canceled
    }
}
