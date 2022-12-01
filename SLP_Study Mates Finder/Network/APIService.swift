//
//  APIService.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/26.
//

import Foundation
import Alamofire

class APIService {
    static func login(completion: @escaping (UserInfo?, Int?, Error?) -> Void) {
        AF.request(login as! URLRequestConvertible).responseDecodable(of: UserInfo.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                completion(data, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }
}
