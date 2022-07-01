//
//  ZeplinKitMockURLProtocol.swift
//  
//
//  Created by Ilian Konchev on 4.02.22.
//

import Foundation
@testable import ZeplinKit

final class ZeplinKitMockURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let (response, data, error) = ZeplinKitMocks.mocked(request: request)
        if let data = data {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } else {
            guard let error = error else {
                client?.urlProtocolDidFinishLoading(self)
                return
            }
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
