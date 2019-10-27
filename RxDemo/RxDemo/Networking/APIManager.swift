import Foundation
import Alamofire
import Moya
import SwiftyJSON
import RxSwift
import RxCocoa
import Moya_ObjectMapper
import ObjectMapper

//extension APIManager {
//    private func request(_ target: BeberiaService) -> Single<Any> {
//        return api.baseRequest(target)
//            .mapJSON()
//            .observeOn(MainScheduler.instance)
//            .asSingle()
//    }
//
//    private func requestWithoutMapping(_ target: BeberiaService) -> Single<Moya.Response> {
//        return api.baseRequest(target)
//            .observeOn(MainScheduler.instance)
//            .asSingle()
//    }
//
//    private func requestObject<T: BaseMappable>(_ target: BeberiaService, type: T.Type) -> Single<T> {
//        return api.baseRequest(target)
//            .mapObject(T.self)
//            .observeOn(MainScheduler.instance)
//            .asSingle()
//    }
//
//    private func requestArray<T: BaseMappable>(_ target: BeberiaService, type: T.Type) -> Single<[T]> {
//        return api.baseRequest(target)
//            .mapArray(T.self)
//            .observeOn(MainScheduler.instance)
//            .asSingle()
//    }
//}

struct APIManager {
    
    static let share = APIManager()
    let bag = DisposeBag()
   // let api = APIManager()
    
    private let provider = MoyaProvider<BeberiaService>()
    
    func baseRequest(_ token: BeberiaService) -> Single<Moya.Response> {
        let actualRequest = MoyaProvider<BeberiaService>().rx.request(token)
      
                return actualRequest
                  //  .filterSuccessfulStatusCodes()
                    .do(onSuccess: { (response) in
                        print(response)
                    }, onError: { (error) in
                        if let error = error as? MoyaError {
                            switch error {
                            case .statusCode(let response):
                                if response.statusCode == 401 {
                                    // Unauthorized
                                    //                                    AuthManager.removeToken()
                                }
                            default:
                                print("ádad")
                                break
                            }
                        }
                    })
    //    }
    }
    
//    static func get()->Single<User>{
//        let parameters: Parameters = [
//                        "display_name" : "user",
//                        "password" : "pass",
//                        "fcm_token" : "fcmToken",
//                        "device": 1
//                    ]
//       return APIManager.baseRequest(.addBabyProfile(param: parameters))
//        .mapObject(User.self)
//
//    }
    
    func get()->Single<User>{
        let parameters: Parameters = [
            "display_name" : "user",
            "password" : "pass",
            "fcm_token" : "fcmToken",
            "device": 1
        ]
        return provider.rx.request(.addBabyProfile(param: parameters)).subscribe(onSuccess: { (respon) in
            print(respon)
        }, onError: { (errr) in
            print(errr)
        }) as! Single<User>
        
    }
    
    // request data
   
    
//    class DefaultAlamofireManager: Alamofire.SessionManager {
//        static let sharedManager: DefaultAlamofireManager = {
//            let configuration = URLSessionConfiguration.default
//            configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//            configuration.timeoutIntervalForRequest = 60 // as seconds, you can set your request timeout
//            configuration.timeoutIntervalForResource = 60 // as seconds, you can set your resource timeout
//            configuration.requestCachePolicy = .useProtocolCachePolicy
//            return DefaultAlamofireManager(configuration: configuration)
//        }()
//    }
//
//    static let provider = MoyaProvider<BeberiaService>(manager: DefaultAlamofireManager.sharedManager)
//
//    static func requestJson(target: BeberiaService, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
//
//        print(target.path)
//        print(target.parameters)
//
//        provider.request(target) { (result) in
//            switch result {
//            case .success(let response):
//                if response.statusCode >= 200 && response.statusCode <= 300 {
//                    successCallback(response)
//                } else {
//                    let error = NSError(domain:"com.vsemenchenko.networkLayer", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
//                    errorCallback(error)
//                }
//            case .failure(let error):
//                failureCallback(error)
//            }
//        }
//    }
//
    
    // MARK: - User
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
}
