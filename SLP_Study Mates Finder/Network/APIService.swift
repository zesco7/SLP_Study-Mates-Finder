//
//  APIService.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/26.
//

import Foundation
import Alamofire
import RxSwift

class APIService {
    
//    static func request<Response>(url: URL, method: HTTPMethod, parameter: [String: String], header: [String: String]) -> Observable<Response> where Response : Decodable {
//        
//        AF.request(url, method: method, parameters: parameter, headers: .init(header)).responseD
//    }
    
    static func login(completion: @escaping (UserInfo?, Int?, Error?) -> Void) {
        let url = EndPoint.login
        let header : HTTPHeaders = ["idtoken": SignUpUserDefaults.idToken.userDefaults, "Content-Type" : "application/x-www-form-urlencoded"]
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
    
    static func signUp(completion: @escaping (String?, Int?, Error?) -> Void) {
        let url = EndPoint.signup
        let header : HTTPHeaders = ["idtoken": SignUpUserDefaults.idToken.userDefaults, "Content-Type" : "application/x-www-form-urlencoded"]
        let userData = UserDefaultsHelper()
        let parameter = ["phoneNumber" : userData.phoneNumber,
                         "FCMtoken" : userData.FCMToken,
                         "nick" : userData.nickName,
                         "birthDate" : userData.birth,
                         "email" : userData.email,
                         "gender" : userData.gender]
        AF.request(url, method: .post, parameters: parameter, headers: header).responseString{ response in
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
