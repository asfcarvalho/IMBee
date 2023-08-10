//
//  MockURLProtocol.swift
//  DataModulesTests
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import Foundation

public class MockURLProtocol: URLProtocol {
    
    static public var stubResponseData: Data?
    static public var error: Error?
    
    public override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    public override func startLoading() {
 
        if let error = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubResponseData ?? Data())
        }
 
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    public override func stopLoading() { }
}
