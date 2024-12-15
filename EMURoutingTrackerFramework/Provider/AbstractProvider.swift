//
//  AbstractData.swift
//  EMURoutingTracker
//
//  Created by Qingyang Hu on 11/8/20.
//

import Foundation
import Moya
import Sentry

class AbstractProvider<T: TargetType> {
    let provider = MoyaProvider<T>(plugins: [])
    
    internal func request<R: Codable> (target: T, type: R.Type, success: @escaping (R) -> Void, failure: ((Error) -> Void)? = nil) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                if (response.statusCode == 200) {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(R.self, from: response.data)
                        success(result)
                    } catch {
                        SentrySDK.capture(error: error)
                        failure?(error)
                    }

                } else {
                    let error = NetworkError(response.statusCode, response.request?.url?.absoluteString ?? "<Empty URL>", String(data: response.data, encoding: .utf8) ?? "<Empty Content>")
                    SentrySDK.capture(error: error)
                    failure?(error)
                }
            case let .failure(error):
                SentrySDK.capture(error: error)
                failure?(error)
            }
        }
    }
    
    internal func requestRaw(target: T, success: @escaping (String) -> Void, failure: ((Error) -> Void)? = nil) {
        provider.request(target) { (result) in
            switch result {
            case let .success(response):
                if (response.statusCode == 200) {
                    success(String(data: response.data, encoding: .utf8) ?? "")
                } else {
                    let error = NetworkError(response.statusCode, response.request?.url?.absoluteString ?? "<Empty URL>", String(data: response.data, encoding: .utf8) ?? "<Empty Content>")
                    SentrySDK.capture(error: error)
                    failure?(error)
                }
            case let .failure(error):
                SentrySDK.capture(error: error)
                failure?(error)
            }
        }
    }
}

struct NetworkError: LocalizedError {
    let code: Int
    let title: String
    let content: String
    init(_ code: Int, _ title: String, _ content: String) {
        self.code = code
        self.title = title
        self.content = content
    }
}
