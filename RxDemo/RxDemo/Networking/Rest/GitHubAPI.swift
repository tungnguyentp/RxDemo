//
//  GitHubAPI.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

protocol ProductAPIType {
    var addXAuth: Bool { get }
}

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

enum GithubAPI {
    
    case contents(fullname: String, path: String, ref: String?)

   
}

extension GithubAPI: TargetType, ProductAPIType {

    var baseURL: URL {
        switch self {

        default:
            return URL.init(string: "sdasd")!
        }
    }

    var path: String {
        switch self {
      
        case .contents(let fullname, let path, _): return "/repos/\(fullname)/contents/\(path)"
      
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var headers: [String: String]? {

            return ["Authorization": "Basic \("token")"]

    }

    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {

        case .contents(_, _, let ref):
            params["ref"] = ref
    
        default: break
        }
        return params
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

//    var localLocation: URL {
//        switch self {
//        case .download(_, let fileName):
//            if let fileName = fileName {
//                return assetDir.appendingPathComponent(fileName)
//            }
//        default: break
//        }
//        return assetDir
//    }

 

    public var task: Task {
     //   switch self {

            return .requestPlain
      //  }
    }

    var sampleData: Data {
        var dataUrl: URL?
        switch self {
       
        case .contents:
     
        return Data()
        }
    }

    var addXAuth: Bool {
        switch self {
        default: return true
        }
    }
}
