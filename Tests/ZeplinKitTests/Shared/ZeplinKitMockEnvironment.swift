//
//  ZeplinKitMockEnvironment.swift
//  
//
//  Created by Ilian Konchev on 2.02.22.
//

@testable import Fetcher
import Foundation
@testable import ZeplinKit

final class ZeplinKitMockEnvironment: FetcherEnvironment {
    var urlSession: URLSession = .shared
    var isNetworkingAvailable = true
    var refreshTokenURL: APIURL? = ZeplinAPIURL.refreshToken(ZeplinKitMocks.zeplinAPIConfiguration)
    var apiErrorsLogger: FetcherLogger?

    func updateToken(to newToken: Token?, logger: FetcherLogger?) async throws -> Token? {
        return ZeplinKitMocks.token
    }

    func refreshToken(_ token: Token?, using fetcher: Fetcher) async throws -> Token? {
        return ZeplinKitMocks.token
    }

    func getToken(logger: FetcherLogger?) async throws -> Token? {
        return ZeplinKitMocks.token
    }

    func logout() async throws {
        // pass
    }

    init() {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ZeplinKitMockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
}

extension Fetcher {
    static let mock = Fetcher(environment: ZeplinKitMockEnvironment())
}
