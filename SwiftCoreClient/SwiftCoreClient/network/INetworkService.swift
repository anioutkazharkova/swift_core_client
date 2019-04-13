//
//  InetworkService?.swift
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 1. All rights reserved.
//

import Foundation
import Alamofire

protocol INetworkService: class {

    func request<T>(url: URLConvertible,
                    parameters: [String: Any],
                    method: Methods,
                    encoding: ParameterEncoding,
                    version: Int,
                    completion: @escaping (ContentResponse<T>) -> Void)

    func request<T>(url: URLConvertible,
                    parameters: [String: Any],
                    method: Methods,
                    completion: @escaping (ContentResponse<T>) -> Void)

    func request<T>(url: URLConvertible,
                    parameters: [String: Any],
                    method: Methods,
                     encoding: ParameterEncoding,
                    completion: @escaping (ContentResponse<T>) -> Void)

    func requestString<T>(url: URLConvertible,
    parameters: [String: Any],
    method: Methods,
    completion: @escaping (ContentResponse<T>) -> Void)

    func requestString<T>(url: URLConvertible,
                          parameters: [String: Any],
                          method: Methods,
                          encoding: ParameterEncoding,
                          version: Int,
                          completion: @escaping (ContentResponse<T>) -> Void)

    func requestString<T>(url: URLConvertible,
                          parameters: [String: Any],
                          method: Methods,
                          encoding: ParameterEncoding,
                          completion: @escaping (ContentResponse<T>) -> Void)

    func processResponse<T>(result: ContentResponse<T>?) -> ContentResponse<SimpleResponse>

    func checkNeedReauth<T>(result: ContentResponse<T>) -> Bool

    func cancelAllRequests()
}
