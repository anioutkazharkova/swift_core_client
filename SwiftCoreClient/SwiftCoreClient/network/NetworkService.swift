//
//  networkService?.swift
//  MoviesSearch
//
//   Created by azharkova on 16.02.2019.
//  Copyright © 2019 azharkova. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

enum Methods {
    case get, post, patch, delete, put
    
    func toMehtod() -> HTTPMethod {
        switch (self) {
        case .get:
            return .get
        case .post:
            return .post
        case .patch:
            return .patch
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
}

class NetworkService: INetworkService {
    
    private var requestSessionManager: SessionManager? = nil
    private var networkConfiguration: INetworkConfiguration
    
    
    init(networkConfiguration: INetworkConfiguration) {
        self.networkConfiguration = networkConfiguration
        requestSessionManager = configSessionManager()
    }
    
    private func configSessionManager() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 180
        configuration.allowsCellularAccess = true
        configuration.httpMaximumConnectionsPerHost = 50
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil 
        return SessionManager(configuration: configuration)
    }
    
    public func request<T>(url: URLConvertible,
                           parameters: [String: Any] = [:],
                           method: Methods, encoding: ParameterEncoding = URLEncoding.default,
                           version: Int = 1,
                           completion: @escaping (ContentResponse<T>) -> Void) {
        
        
        let urlEncoding = encoding
        let requestURL = "\(self.networkConfiguration.getBaseUrl())\(url)".encodeUrl
        let headers = self.networkConfiguration.getHeadersWithVersion(version: version)
        
        let queue = DispatchQueue(label: "queue\(Date().timeIntervalSince1970)",
            qos: .userInitiated,
            attributes:.concurrent)
        DispatchQueue.main.async { [weak self] in
            
            self?.requestSessionManager?.request(requestURL, method: method.toMehtod(), parameters: parameters, encoding: urlEncoding, headers: headers)
                .responseJSON(queue: queue) { response in
                    if let _ = response.error {
                        let errorResult = ContentResponse<T>(error: EError(type: .network))
                        DispatchQueue.main.async {
                            completion(errorResult)
                        }
                        return
                    }
                    
                    guard let urlResponse = response.response, let json = response.value else {
                        let errorResult = ContentResponse<T>(error: EError(type: .network))
                        DispatchQueue.main.async {
                            completion(errorResult)
                        }
                        return
                    }
                    let result = ContentResponse<T>(response: urlResponse, json: json)
                    
                    DispatchQueue.main.async {
                        completion(result)
                    }
            }
        }
    }
    
    public func request<T>(url: URLConvertible,
                           parameters: [String: Any] = [:],
                           method: Methods,
                           encoding: ParameterEncoding = URLEncoding.default,
                           completion: @escaping (ContentResponse<T>) -> Void) {
        self.request(url: url, parameters: parameters, method: method, encoding: encoding, version: 1, completion: completion)
    }
    
    public func request<T>(url: URLConvertible,
                           parameters: [String: Any] = [:],
                           method: Methods,
                           completion: @escaping (ContentResponse<T>) -> Void) {
        self.request(url: url, parameters: parameters, method: method, encoding: URLEncoding.default, version: 1,  completion: completion)
    }
    
    public func requestString<T>(url: URLConvertible,
                                 parameters: [String: Any],
                                 method: Methods,
                                 completion: @escaping (ContentResponse<T>) -> Void) {
        self.requestString(url: url, parameters: parameters, method: method, encoding: JSONEncoding.default, version: 1, completion: completion)
    }
    
    public func requestString<T>(url: URLConvertible,
                                 parameters: [String: Any],
                                 method: Methods,
                                 encoding: ParameterEncoding,
                                 completion: @escaping (ContentResponse<T>) -> Void) {
        self.requestString(url: url, parameters: parameters, method: method, encoding: encoding, version: 1, completion: completion)
    }
    
    public func requestString<T>(url: URLConvertible,
                                 parameters: [String: Any] = [:],
                                 method: Methods, encoding: ParameterEncoding,
                                 version: Int = 1,
                                 completion: @escaping (ContentResponse<T>) -> Void) {
        
        let urlEncoding = encoding
        let requestURL = "\(self.networkConfiguration.getBaseUrl())\(url)".encodeUrl
        let headers = self.networkConfiguration.getHeadersWithVersion(version: version)
        
        let queue = DispatchQueue(label: "queue",
                                  qos: .userInitiated,
                                  attributes:.concurrent)
        DispatchQueue.main.async { [weak self] in
            self?.requestSessionManager?.request(requestURL, method: method.toMehtod(), parameters: parameters, encoding: urlEncoding, headers: headers)
                .responseString(queue: queue)  { response in
                    
                    
                    if let error = response.error {
                        let type: ErrorType = (error as NSError).code == NSURLErrorCancelled ? .canceled : .network
                        let errorResult = ContentResponse<T>(error: EError(type: type))
                        DispatchQueue.main.async {
                            completion(errorResult)
                        }
                        return
                    }
                    
                    guard let urlResponse = response.response, let json = response.value else {
                        let errorResult = ContentResponse<T>(error: EError(type: .network))
                        DispatchQueue.main.async {
                            completion(errorResult)
                        }
                        return
                    }
                    let result = ContentResponse<T>(response: urlResponse, json: json)
                    DispatchQueue.main.async {
                        
                        completion(result)
                    }
                    
            }
        }
    }
    
    func checkNeedReauth<T: Any&Mappable>(result: ContentResponse<T>) -> Bool {
        return result.code == 401 || result.code == 403
    }
    
    func processResponse<T: Any&Mappable>(result: ContentResponse<T>?) -> ContentResponse<SimpleResponse> {
        let response: ContentResponse<SimpleResponse> = ContentResponse<SimpleResponse>()
        response.error = result?.error
        if let code = result?.code {
            response.content = SimpleResponse(isSuccess: code >= 200 && code < 400)
        }
        return response
    }
    
    func cancelAllRequests() {
        requestSessionManager?.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}
