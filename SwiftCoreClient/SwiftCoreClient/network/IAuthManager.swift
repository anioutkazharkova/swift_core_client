//
//  IauthManager?.swift
//   
//
//   Created by azharkova on 27.02.2019.
//  Copyright © 2019 Anna Zharkova. All rights reserved.
//

import Foundation

protocol IAuthManager : class {
    func auth(username: String?, password: String?, completion: @escaping(ContentResponse<TokenResponse>) -> Void)
    func reauth(completion: @escaping(ContentResponse<TokenResponse>) -> Void)
}
