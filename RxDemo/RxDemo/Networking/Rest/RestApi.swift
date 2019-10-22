//
//  RestApi.swift
//  SwiftHub
//
//  Created by Sygnoos9 on 3/9/19.
//  Copyright © 2019 Khoren Markosyan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import Alamofire

typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case serverError(response: ErrorResponse)
}

class RestApi: SwiftHubAPI {

    let githubProvider: GithubNetworking
    let trendingGithubProvider: TrendingGithubNetworking

    init(githubProvider: GithubNetworking, trendingGithubProvider: TrendingGithubNetworking) {
        self.githubProvider = githubProvider
        self.trendingGithubProvider = trendingGithubProvider
    }
}

extension RestApi {


}

extension RestApi {
    private func request(_ target: GithubAPI) -> Single<Any> {
        return githubProvider.request(target)
            .mapJSON()
            .observeOn(MainScheduler.instance)
            .asSingle()
    }

    private func requestWithoutMapping(_ target: GithubAPI) -> Single<Moya.Response> {
        return githubProvider.request(target)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }

    private func requestObject<T: BaseMappable>(_ target: GithubAPI, type: T.Type) -> Single<T> {
        return githubProvider.request(target)
            .mapObject(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }

    private func requestArray<T: BaseMappable>(_ target: GithubAPI, type: T.Type) -> Single<[T]> {
        return githubProvider.request(target)
            .mapArray(T.self)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
}

