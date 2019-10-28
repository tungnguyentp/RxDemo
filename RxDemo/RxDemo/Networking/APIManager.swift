import Foundation
import Alamofire
import Moya
import SwiftyJSON
import RxSwift
import RxCocoa
import Moya_ObjectMapper
import ObjectMapper

extension Observable {
    func mapObject1<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw MoyaError.jsonMapping(response as! Response)
            }
            return Mapper<T>().map(JSON: dict["data"] as! [String : Any])!
        }
    }
    
    func mapArray1<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in
            //if response is an array of dictionaries, then use ObjectMapper to map the dictionary
            //if not, throw an error
            guard let array = response as? [[String: Any]] else {
                throw MoyaError.jsonMapping(response as! Response)
            }
            return Mapper<T>().mapArray(JSONArray: array)
        }
    }
}

extension APIManager {
    private func request(_ target: BeberiaService) -> Single<Any> {
        return APIManager.baseRequest(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
          //  .asSingle()
    }

    private func requestWithoutMapping(_ target: BeberiaService) -> Single<Moya.Response> {
        return APIManager.baseRequest(target)
            .observeOn(MainScheduler.instance)
          //  .asSingle()
    }

    private func requestObject<T: BaseMappable>(_ target: BeberiaService, type: T.Type, key1: String, key2: String = "") -> Single<T> {
        return APIManager.baseRequest(target)
            .map({ (response) -> T in
                do {
                    guard let dict = try response.mapJSON() as? [String:Any] else{
                        throw MoyaError.jsonMapping(response)
                    }
                    if key2 == ""{
                        return Mapper<T>().map(JSON: (dict[key1] as! [String : Any]))!
                    }
                    return Mapper<T>().map(JSON: (dict[key1] as! [String : Any])[key2] as! [String : Any])!
                }
            })
            .observeOn(MainScheduler.instance)
    }

    private func requestArray<T: BaseMappable>(_ target: BeberiaService, type: T.Type, key1: String, key2: String = "") -> Single<[T]> {
        return APIManager.baseRequest(target)
            .map({ (response) -> [T] in
                do {
                    guard let dict = try response.mapJSON() as? [String:Any] else{
                        throw MoyaError.jsonMapping(response)
                    }
                    guard let array = dict[key1] as? [[String:Any]] else{
                        throw MoyaError.jsonMapping(response)
                    }
                    if key2 == ""{
                        return Mapper<T>().mapArray(JSONArray: array)
                    }
                    return Mapper<T>().mapArray(JSONArray: [(dict[key1] as! [String : Any])[key2] as! [String : Any]])
                }
            })
            .observeOn(MainScheduler.instance)
    }
}

struct APIManager {
    
    static let share = APIManager()
    static let bag = DisposeBag()
    
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
    
    static let provider = MoyaProvider<BeberiaService>()
    
    static func baseRequest(_ token: BeberiaService) -> Single<Moya.Response> {
        let actualRequest = APIManager.provider.rx.request(token)
        return actualRequest
            .filterSuccessfulStatusCodes()
            .do(onSuccess: { (response) in
                print(response)
            }, onError: { (error) in
                if let error = error as? MoyaError {
                    switch error {
                    case .statusCode(let response):
                        if response.statusCode == 401 {
                            // Unauthorized
                            // AuthManager.removeToken()
                        }
                    default:
                        print("ádad")
                        break
                    }
                }
            })
    }
    
    static func login()->Single<User>{
        let parameters: Parameters = [
                        "display_name" : "luongyen",
                        "password" : "123456",
                        "fcm_token" : "fcmToken",
                        "device": 1
                    ]
        
        return APIManager.share.requestObject(.login(param: parameters), type: User.self, key1: "data", key2: "user")
    }
    
    static func getListCategory()->Single<[CategoryModel]>{
        let parameters: Parameters = [
            "category_id" : 3,
            "type":0,
            "location": 1
        ]
    
        return APIManager.share.requestArray(.getCategory(param: parameters), type: CategoryModel.self, key1: "data")
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
