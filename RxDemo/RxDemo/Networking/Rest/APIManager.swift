//
//  APIManager.swift
//
//
//  Created by Mac on 1/16/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import Alamofire
import Moya
import Rswift
import RxCocoa

struct APIManager {
    
    class DefaultAlamofireManager: Alamofire.SessionManager {
        static let sharedManager: DefaultAlamofireManager = {
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
            configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
            configuration.timeoutIntervalForResource = 60 // as seconds, you can set your resource timeout
            configuration.requestCachePolicy = .useProtocolCachePolicy
            return DefaultAlamofireManager(configuration: configuration)
        }()
    }
    
    static let provider = MoyaProvider<BeberiaService>(manager: DefaultAlamofireManager.sharedManager)
    
    static func requestJsonRx(target: BeberiaService) -> Signal<[String: Any]> {
        return Signal.create({ observer -> Disposable in
            let request = APIProvider.shared.request(api, completion: { result in
                do {
                    switch result {
                    case .success(let response):
                        let json = try response.mapJSON()
                        if let jsonDict = json as? [String: Any] {
                            observer.onNext(jsonDict)
                            observer.onComplete()
                        } else {
                            throw ResponseError.invalidJSONFormat
                        }
                    case .failure(let error):
                        throw error
                    }
                } catch let error {
                    observer.onError(error)
                    observer.onComplete()
                }
            })
            return Disposables.create {
                request.cancel()
            }
        })
    }

    static func requestJson(target: BeberiaService, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {

        print(target.path)
        print(target.parameters)
        
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                } else {
                    let error = NSError(domain:"com.vsemenchenko.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
    static func login(user: String, pass: String, fcmToken: String) -> Signal<User> {
        
        let parameters: Parameters = [
        "display_name" : user,
        "password" : pass,
        "fcm_token" : fcmToken,
        "device": 1
        ]
        print(parameters)
        
        return requestJsonRx(target: .login(param: parameters)).map({ json in
        //    print(json)
            if let book = User(JSON: json) {
                return book
            } else {
                throw ResponseError.invalidJSONFormat
            }
        })
    }
    
  
//    // MARK: - User
//    static func login(user: String, pass: String,fcmToken: String, callbackSuccess: @escaping (_ typeCar: User) -> Void, failed callbackFailure: @escaping (_ message: String,_ statusCode: Int,_ display_name: String,_ password:String ) -> Void) {
//        let parameters: Parameters = [
//            "display_name" : user,
//            "password" : pass,
//            "fcm_token" : fcmToken,
//            "device": 1
//        ]
//        print(parameters)
//        
//        self.requestJson(target: .login(param: parameters), success: { (response) in
//            do {
//                let json = try JSON.init(data: response.data)
//                if json["status"].intValue == 200{
//                    let user = User.init(json: json["data"]["user"])
//                    UserInfo.shareUserInfo.initDataUser(json: json["data"])
//                    callbackSuccess(user)
//                }else{
//                    callbackFailure(json["message"].stringValue, json["status"].intValue, json["message"]["display_name"][0].stringValue, json["message"]["password"][0].stringValue)
//                }
//            } catch {
//                callbackFailure("Có lỗi xảy ra", 0, "", "")
//            }
//        }, error: { (error) in
//            callbackFailure(error.localizedDescription, 0, "", "")
//        }) { (error) in
//            callbackFailure(error.localizedDescription, 0, "", "")
//        }
//    }

   
   
}
