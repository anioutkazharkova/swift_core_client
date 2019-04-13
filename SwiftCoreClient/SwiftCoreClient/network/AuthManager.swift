//
//  authManager?.swift
//   
//
//   Created by azharkova on 27.02.2019.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import UIKit

class AuthManager: IAuthManager {
    
    private weak var networkService = DI.container.networkService
    private weak var networkConfig = DI.container.networkConfig
    
    func auth(username: String?, password: String?, completion: @escaping(ContentResponse<TokenResponse>) -> Void) {
        var parameters = networkConfig?.getSecretCredentials() ?? [String:String]()
        
        parameters.updateValue("client_credentials", forKey: "grant_type")
        if let user = username, let pas = password {
            if (!user.isEmpty() && !pas.isEmpty()) {
                parameters.updateValue(user, forKey: "username")
                parameters.updateValue(pas, forKey: "password")
                parameters.updateValue("password", forKey: "grant_type")
            }
        }
        
        self.networkService?.request(url: "authorization", parameters: parameters, method: .get) {[weak self] (result: ContentResponse<TokenResponse>) in
            
            if  let refreshToken = result.content?.refreshToken {
                self?.networkConfig?.refreshToken(refreshToken: refreshToken)
            }
            self?.networkConfig?.setToken(token: result.content?.token ?? "")
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func reauth(completion: @escaping(ContentResponse<TokenResponse>) -> Void) {
        var parameters = networkConfig?.getSecretCredentials() ?? [String:String]()
        
        parameters.updateValue("refresh_token", forKey: "grant_type")
        if let refreshToken = networkConfig?.refreshToken {
            parameters.updateValue(refreshToken, forKey: "refresh_token")
        }
        self.networkService?.request(url: "authorization", parameters: parameters, method: .get) {[weak self] (result: ContentResponse<TokenResponse>) in
            
            if  let refreshToken = result.content?.refreshToken {
                self?.networkConfig?.refreshToken(refreshToken: refreshToken)
            }
            self?.networkConfig?.setToken(token: result.content?.token ?? "")
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
