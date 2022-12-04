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
        let url = EndPoint.login
        let header : HTTPHeaders = ["idtoken": UserDefaults.standard.string(forKey: "authVerificationID")!, "Content-Type" : "application/x-www-form-urlencoded"]
        AF.request(url, method: .get, headers: header ).responseDecodable(of: UserInfo.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                completion(data, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }
    
    static func loginByServerToken(completion: @escaping (UserInfo?, Int?, Error?) -> Void) {
        let url = EndPoint.login
        let header : HTTPHeaders = ["idtoken": UserDefaults.standard.string(forKey: "serverToken")!, "Content-Type" : "application/x-www-form-urlencoded"]
        AF.request(url, method: .get, headers: header ).responseDecodable(of: UserInfo.self) { response in
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
