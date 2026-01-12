//
//  TokenTests.swift
//
//
//  Created by Ilian Konchev on 8.02.22.
//

import XCTest

@testable import Fetcher
@testable import ZeplinKit

final class TokenTests: XCTestCase {
    let fetcher = Fetcher.mock

    func testGetToken() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.getToken
        let configuration = ZeplinKitMocks.zeplinAPIConfiguration

        // WHEN
        let token: Token = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/oauth/token")
        XCTAssertEqual(sut.apiURL.requestMethod, "POST")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["client_id"] as? String, configuration.clientId)
        XCTAssertEqual(bodyParams["client_secret"] as? String, configuration.clientSecret)
        XCTAssertEqual(bodyParams["redirect_uri"] as? String, configuration.redirectURI)
        XCTAssertEqual(bodyParams["grant_type"] as? String, "authorization_code")
        XCTAssertEqual(bodyParams["code"] as? String, ZeplinKitMocks.code)
        XCTAssertEqual(token.accessToken, "abc123")
        XCTAssertEqual(token.refreshToken, "123abc")
        XCTAssertEqual(token.expiresIn, 3_600_000)
        XCTAssertEqual(token.refreshExpiresIn, 86_400_000)
    }

    func testRefreshToken() async throws {
        // GIVEN
        let sut = ZeplinKitURLMock.refreshToken
        let configuration = ZeplinKitMocks.zeplinAPIConfiguration
        let oldToken = ZeplinKitMocks.token

        // WHEN
        let token: Token = try await fetcher.fetch(sut.apiURL)

        // THEN
        XCTAssertEqual(sut.apiURL.url?.absoluteString, "https://api.zeplin.dev/v1/oauth/token")
        XCTAssertEqual(sut.apiURL.requestMethod, "POST")
        guard let bodyParams = sut.apiURL.bodyParams(token: ZeplinKitMocks.token) else {
            return XCTFail("Unable to infer the request body")
        }
        XCTAssertEqual(bodyParams["client_id"] as? String, configuration.clientId)
        XCTAssertEqual(bodyParams["client_secret"] as? String, configuration.clientSecret)
        XCTAssertEqual(bodyParams["refresh_token"] as? String, oldToken.refreshToken)
        XCTAssertEqual(bodyParams["grant_type"] as? String, "refresh_token")
        XCTAssertEqual(token.accessToken, "abc123")
        XCTAssertEqual(token.refreshToken, "123abc")
        XCTAssertEqual(token.expiresIn, 3_600_000)
        XCTAssertEqual(token.refreshExpiresIn, 86_400_000)
    }
}
